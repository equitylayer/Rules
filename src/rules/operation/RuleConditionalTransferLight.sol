// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {AccessControlEnumerable} from "OZ/access/extensions/AccessControlEnumerable.sol";
import {IERC165} from "OZ/utils/introspection/IERC165.sol";
import {IRule} from "RuleEngine/interfaces/IRule.sol";
import {RuleInterfaceId} from "RuleEngine/modules/library/RuleInterfaceId.sol";
import {ERC1404ExtendInterfaceId} from "CMTAT/library/ERC1404ExtendInterfaceId.sol";
import {RuleEngineInterfaceId} from "CMTAT/library/RuleEngineInterfaceId.sol";
import {AccessControlModuleStandalone} from "../../modules/AccessControlModuleStandalone.sol";
import {RuleConditionalTransferLightBase} from "./abstract/RuleConditionalTransferLightBase.sol";

/**
 * @title ConditionalTransferLight
 * @dev Requires operator approval for each transfer. Same transfer (from, to, value)
 *      can be approved multiple times to allow repeated transfers.
 */
contract RuleConditionalTransferLight is AccessControlModuleStandalone, RuleConditionalTransferLightBase {
    /**
     * @param admin Address of the contract admin.
     */
    constructor(address admin) AccessControlModuleStandalone(admin) {}

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControlEnumerable, IERC165)
        returns (bool)
    {
        return interfaceId == RuleEngineInterfaceId.RULE_ENGINE_INTERFACE_ID
            || interfaceId == ERC1404ExtendInterfaceId.ERC1404EXTEND_INTERFACE_ID
            || interfaceId == RuleInterfaceId.IRULE_INTERFACE_ID
            || AccessControlEnumerable.supportsInterface(interfaceId);
    }

    function _authorizeTransferApproval() internal view virtual override onlyRole(OPERATOR_ROLE) {}

    function _onlyComplianceManager() internal virtual override onlyRole(COMPLIANCE_MANAGER_ROLE) {}
}
