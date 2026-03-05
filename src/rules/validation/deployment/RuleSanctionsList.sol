// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {AccessControl} from "OZ/access/AccessControl.sol";
import {Context} from "OZ/utils/Context.sol";
import {AccessControlModuleStandalone} from "../../../modules/AccessControlModuleStandalone.sol";
import {MetaTxModuleStandalone, ERC2771Context} from "../../../modules/MetaTxModuleStandalone.sol";
import {RuleSanctionsListBase} from "../abstract/base/RuleSanctionsListBase.sol";
import {RuleTransferValidation} from "../abstract/core/RuleTransferValidation.sol";
import {ISanctionsList} from "../../interfaces/ISanctionsList.sol";

/**
 * @title RuleSanctionsList
 * @notice Compliance rule enforcing sanctions-screening for token transfers.
 */
contract RuleSanctionsList is AccessControlModuleStandalone, RuleSanctionsListBase {
    /**
     * @param admin Address of the contract (Access Control)
     * @param forwarderIrrevocable Address of the forwarder, required for the gasless support
     */
    constructor(address admin, address forwarderIrrevocable, ISanctionsList sanctionContractOracle_)
        AccessControlModuleStandalone(admin)
        RuleSanctionsListBase(forwarderIrrevocable, sanctionContractOracle_)
    {}

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControl, RuleTransferValidation)
        returns (bool)
    {
        return AccessControl.supportsInterface(interfaceId) || RuleTransferValidation.supportsInterface(interfaceId);
    }

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    function _authorizeSanctionListManager() internal view virtual override onlyRole(SANCTIONLIST_ROLE) {}

    /*//////////////////////////////////////////////////////////////
                           ERC-2771
    //////////////////////////////////////////////////////////////*/

    function _msgSender() internal view virtual override(ERC2771Context, Context) returns (address sender) {
        return ERC2771Context._msgSender();
    }

    function _msgData() internal view virtual override(ERC2771Context, Context) returns (bytes calldata) {
        return ERC2771Context._msgData();
    }

    function _contextSuffixLength() internal view virtual override(ERC2771Context, Context) returns (uint256) {
        return ERC2771Context._contextSuffixLength();
    }
}
