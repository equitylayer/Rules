// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {RuleAddressSet} from "./RuleAddressSet/RuleAddressSet.sol";
import {RuleValidateTransfer} from "./RuleValidateTransfer.sol";
import {RuleBlacklistInvariantStorage} from "./RuleAddressSet/invariantStorage/RuleBlacklistInvariantStorage.sol";
import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {IERC3643IComplianceContract} from "CMTAT/interfaces/tokenization/IERC3643Partial.sol";
import {IRuleEngine} from "CMTAT/interfaces/engine/IRuleEngine.sol";
import {IRule} from "RuleEngine/interfaces/IRule.sol";
import {
    IERC7943NonFungibleComplianceExtend
} from "../../interfaces/IERC7943NonFungibleCompliance.sol";

/**
 * @title RuleBlacklistBase
 * @notice Core blacklist logic without access-control policy.
 */
abstract contract RuleBlacklistBase is RuleAddressSet, RuleValidateTransfer, RuleBlacklistInvariantStorage {
    constructor(address forwarderIrrevocable) RuleAddressSet(forwarderIrrevocable) {}

    function detectTransferRestriction(address from, address to, uint256 /* value */ )
        public
        view
        override(IERC1404)
        returns (uint8)
    {
        if (isAddressListed(from)) {
            return CODE_ADDRESS_FROM_IS_BLACKLISTED;
        } else if (isAddressListed(to)) {
            return CODE_ADDRESS_TO_IS_BLACKLISTED;
        } else {
            return uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
        }
    }

    function detectTransferRestriction(address from, address to, uint256 /* tokenId */, uint256 value)
        public
        view
        override(IERC7943NonFungibleComplianceExtend)
        returns (uint8)
    {
        return detectTransferRestriction(from, to, value);
    }

    function detectTransferRestrictionFrom(address spender, address from, address to, uint256 value)
        public
        view
        override(IERC1404Extend)
        returns (uint8)
    {
        if (isAddressListed(spender)) {
            return CODE_ADDRESS_SPENDER_IS_BLACKLISTED;
        } else {
            return detectTransferRestriction(from, to, value);
        }
    }

    function detectTransferRestrictionFrom(
        address spender,
        address from,
        address to,
        uint256 /* tokenId */,
        uint256 value
    ) public view override(IERC7943NonFungibleComplianceExtend) returns (uint8) {
        return detectTransferRestrictionFrom(spender, from, to, value);
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

    function supportsInterface(bytes4 interfaceId) public view virtual override(RuleValidateTransfer) returns (bool) {
        return RuleValidateTransfer.supportsInterface(interfaceId);
    }

    function transferred(address from, address to, uint256 value)
        public
        view
        virtual
        override(IERC3643IComplianceContract)
    {
        uint8 code = this.detectTransferRestriction(from, to, value);
        require(
            code == uint8(REJECTED_CODE_BASE.TRANSFER_OK),
            RuleBlacklist_InvalidTransfer(address(this), from, to, value, code)
        );
    }

    function transferred(address spender, address from, address to, uint256 value)
        public
        view
        virtual
        override(IRuleEngine)
    {
        uint8 code = this.detectTransferRestrictionFrom(spender, from, to, value);
        require(
            code == uint8(REJECTED_CODE_BASE.TRANSFER_OK),
            RuleBlacklist_InvalidTransferFrom(address(this), spender, from, to, value, code)
        );
    }

    function transferred(address spender, address from, address to, uint256 /* tokenId */, uint256 value)
        public
        view
        virtual
        override(IERC7943NonFungibleComplianceExtend)
    {
        transferred(spender, from, to, value);
    }

    function transferred(address from, address to, uint256 /* tokenId */, uint256 value)
        public
        view
        virtual
        override(IERC7943NonFungibleComplianceExtend)
    {
        transferred(from, to, value);
    }
}
