// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {RuleAddressSet} from "../RuleAddressSet/RuleAddressSet.sol";
import {RuleNFTAdapter} from "../core/RuleNFTAdapter.sol";
import {RuleTransferValidation} from "../core/RuleTransferValidation.sol";
import {RuleBlacklistInvariantStorage} from "../RuleAddressSet/invariantStorage/RuleBlacklistInvariantStorage.sol";
import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {IERC3643IComplianceContract} from "CMTAT/interfaces/tokenization/IERC3643Partial.sol";
import {IRuleEngine} from "CMTAT/interfaces/engine/IRuleEngine.sol";
import {IRule} from "RuleEngine/interfaces/IRule.sol";

/**
 * @title RuleBlacklistBase
 * @notice Core blacklist logic without access-control policy.
 */
abstract contract RuleBlacklistBase is RuleAddressSet, RuleNFTAdapter, RuleBlacklistInvariantStorage {
    /*//////////////////////////////////////////////////////////////
                             CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address forwarderIrrevocable) RuleAddressSet(forwarderIrrevocable) {}

    /*//////////////////////////////////////////////////////////////
                          PUBLIC FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @inheritdoc IERC3643IComplianceContract
     * @dev Validation only; does not modify state.
     */
    function transferred(address from, address to, uint256 value)
        public
        view
        virtual
        override(IERC3643IComplianceContract)
    {
        _transferred(from, to, value);
    }

    /**
     * @inheritdoc IRuleEngine
     * @dev Validation only; does not modify state.
     */
    function transferred(address spender, address from, address to, uint256 value)
        public
        view
        virtual
        override(IRuleEngine)
    {
        _transferredFrom(spender, from, to, value);
    }

    function canReturnTransferRestrictionCode(uint8 restrictionCode)
        public
        pure
        virtual
        override(IRule)
        returns (bool)
    {
        return restrictionCode == CODE_ADDRESS_FROM_IS_BLACKLISTED || restrictionCode == CODE_ADDRESS_TO_IS_BLACKLISTED
            || restrictionCode == CODE_ADDRESS_SPENDER_IS_BLACKLISTED;
    }

    function messageForTransferRestriction(uint8 restrictionCode)
        public
        pure
        virtual
        override(IERC1404)
        returns (string memory)
    {
        if (restrictionCode == CODE_ADDRESS_FROM_IS_BLACKLISTED) {
            return TEXT_ADDRESS_FROM_IS_BLACKLISTED;
        } else if (restrictionCode == CODE_ADDRESS_TO_IS_BLACKLISTED) {
            return TEXT_ADDRESS_TO_IS_BLACKLISTED;
        } else if (restrictionCode == CODE_ADDRESS_SPENDER_IS_BLACKLISTED) {
            return TEXT_ADDRESS_SPENDER_IS_BLACKLISTED;
        } else {
            return TEXT_CODE_NOT_FOUND;
        }
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(RuleTransferValidation) returns (bool) {
        return RuleTransferValidation.supportsInterface(interfaceId);
    }

    /*//////////////////////////////////////////////////////////////
                        INTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function _detectTransferRestriction(
        address from,
        address to,
        uint256 /* value */
    )
        internal
        view
        override
        returns (uint8)
    {
        if (isAddressListed(from)) {
            return CODE_ADDRESS_FROM_IS_BLACKLISTED;
        } else if (isAddressListed(to)) {
            return CODE_ADDRESS_TO_IS_BLACKLISTED;
        }
        return uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
    }

    function _detectTransferRestrictionFrom(address spender, address from, address to, uint256 value)
        internal
        view
        override
        returns (uint8)
    {
        if (isAddressListed(spender)) {
            return CODE_ADDRESS_SPENDER_IS_BLACKLISTED;
        }
        return _detectTransferRestriction(from, to, value);
    }

    function _transferred(address from, address to, uint256 value) internal view virtual override {
        uint8 code = _detectTransferRestriction(from, to, value);
        require(
            code == uint8(REJECTED_CODE_BASE.TRANSFER_OK),
            RuleBlacklist_InvalidTransfer(address(this), from, to, value, code)
        );
    }

    function _transferredFrom(address spender, address from, address to, uint256 value) internal view virtual override {
        uint8 code = _detectTransferRestrictionFrom(spender, from, to, value);
        require(
            code == uint8(REJECTED_CODE_BASE.TRANSFER_OK),
            RuleBlacklist_InvalidTransferFrom(address(this), spender, from, to, value, code)
        );
    }
}
