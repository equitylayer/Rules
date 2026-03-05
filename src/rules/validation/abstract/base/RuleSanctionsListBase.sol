// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {MetaTxModuleStandalone} from "../../../../modules/MetaTxModuleStandalone.sol";
import {RuleSanctionsListInvariantStorage} from "../invariant/RuleSanctionsListInvariantStorage.sol";
import {RuleNFTAdapter} from "../core/RuleNFTAdapter.sol";
import {ISanctionsList} from "../../../interfaces/ISanctionsList.sol";
import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {IERC3643IComplianceContract} from "CMTAT/interfaces/tokenization/IERC3643Partial.sol";
import {IRuleEngine} from "CMTAT/interfaces/engine/IRuleEngine.sol";
import {IRule} from "RuleEngine/interfaces/IRule.sol";

/**
 * @title RuleSanctionsListBase
 * @notice Compliance rule enforcing sanctions-screening for token transfers.
 */
abstract contract RuleSanctionsListBase is MetaTxModuleStandalone, RuleNFTAdapter, RuleSanctionsListInvariantStorage {
    ISanctionsList public sanctionsList;

    constructor(address forwarderIrrevocable, ISanctionsList sanctionContractOracle_)
        MetaTxModuleStandalone(forwarderIrrevocable)
    {
        if (address(sanctionContractOracle_) != address(0)) {
            _setSanctionListOracle(sanctionContractOracle_);
        }
    }

    function _detectTransferRestriction(address from, address to, uint256 /* value */)
        internal
        view
        override
        returns (uint8)
    {
        if (address(sanctionsList) != address(0)) {
            if (sanctionsList.isSanctioned(from)) {
                return CODE_ADDRESS_FROM_IS_SANCTIONED;
            } else if (sanctionsList.isSanctioned(to)) {
                return CODE_ADDRESS_TO_IS_SANCTIONED;
            }
        }
        return uint8(REJECTED_CODE_BASE.TRANSFER_OK);
    }

    function _detectTransferRestrictionFrom(address spender, address from, address to, uint256 value)
        internal
        view
        virtual
        override
        returns (uint8)
    {
        if (address(sanctionsList) != address(0)) {
            if (sanctionsList.isSanctioned(spender)) {
                return CODE_ADDRESS_SPENDER_IS_SANCTIONED;
            }
            return _detectTransferRestriction(from, to, value);
        }
        return uint8(REJECTED_CODE_BASE.TRANSFER_OK);
    }

    function canReturnTransferRestrictionCode(uint8 restrictionCode) external pure override(IRule) returns (bool) {
        return restrictionCode == CODE_ADDRESS_FROM_IS_SANCTIONED || restrictionCode == CODE_ADDRESS_TO_IS_SANCTIONED
            || restrictionCode == CODE_ADDRESS_SPENDER_IS_SANCTIONED;
    }

    function messageForTransferRestriction(uint8 restrictionCode)
        public
        pure
        override(IERC1404)
        returns (string memory)
    {
        if (restrictionCode == CODE_ADDRESS_FROM_IS_SANCTIONED) {
            return TEXT_ADDRESS_FROM_IS_SANCTIONED;
        } else if (restrictionCode == CODE_ADDRESS_TO_IS_SANCTIONED) {
            return TEXT_ADDRESS_TO_IS_SANCTIONED;
        } else if (restrictionCode == CODE_ADDRESS_SPENDER_IS_SANCTIONED) {
            return TEXT_ADDRESS_SPENDER_IS_SANCTIONED;
        }
        return TEXT_CODE_NOT_FOUND;
    }

    function setSanctionListOracle(ISanctionsList sanctionContractOracle_) public virtual onlySanctionListManager {
        require(address(sanctionContractOracle_) != address(0), RuleSanctionsList_OracleAddressZeroNotAllowed());
        _setSanctionListOracle(sanctionContractOracle_);
    }

    function clearSanctionListOracle() public virtual onlySanctionListManager {
        _setSanctionListOracle(ISanctionsList(address(0)));
    }

    function transferred(address from, address to, uint256 value)
        public
        view
        override(IERC3643IComplianceContract)
    {
        _transferred(from, to, value);
    }

    function transferred(address spender, address from, address to, uint256 value)
        public
        view
        override(IRuleEngine)
    {
        _transferredFrom(spender, from, to, value);
    }

    function _transferred(address from, address to, uint256 value) internal view virtual override {
        uint8 code = _detectTransferRestriction(from, to, value);
        require(
            code == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK),
            RuleSanctionsList_InvalidTransfer(address(this), from, to, value, code)
        );
    }

    function _transferredFrom(address spender, address from, address to, uint256 value)
        internal
        view
        virtual
        override
    {
        uint8 code = _detectTransferRestrictionFrom(spender, from, to, value);
        require(
            code == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK),
            RuleSanctionsList_InvalidTransferFrom(address(this), spender, from, to, value, code)
        );
    }

    function _setSanctionListOracle(ISanctionsList sanctionContractOracle_) internal virtual {
        sanctionsList = sanctionContractOracle_;
        emit SetSanctionListOracle(sanctionContractOracle_);
    }

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    modifier onlySanctionListManager() {
        _authorizeSanctionListManager();
        _;
    }

    function _authorizeSanctionListManager() internal view virtual;
}
