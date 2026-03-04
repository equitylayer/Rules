// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {AccessControl} from "OZ/access/AccessControl.sol";
import {IERC165} from "OZ/utils/introspection/IERC165.sol";
import {IRuleEngine} from "CMTAT/interfaces/engine/IRuleEngine.sol";
import {IRule} from "RuleEngine/interfaces/IRule.sol";
import {RuleInterfaceId} from "RuleEngine/modules/library/RuleInterfaceId.sol";
import {RuleConditionalTransferLightBase} from "./abstract/RuleConditionalTransferLightBase.sol";

/**
 * @title ConditionalTransferLight
 * @dev Requires operator approval for each transfer. Same transfer (from, to, value)
 *      can be approved multiple times to allow repeated transfers.
 */
contract RuleConditionalTransferLight is
    AccessControl,
    RuleConditionalTransferLightBase
{
    constructor(address admin, IRuleEngine ruleEngineContract) {
        require(admin != address(0), RuleConditionalTransferLight_AdminAddressZeroNotAllowed());

        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(OPERATOR_ROLE, admin);
        if (address(ruleEngineContract) != address(0)) {
            _grantRole(RULE_ENGINE_CONTRACT_ROLE, address(ruleEngineContract));
        }
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControl, IERC165)
        returns (bool)
    {
        return interfaceId == RuleInterfaceId.IRULE_INTERFACE_ID || interfaceId == type(IRule).interfaceId
            || AccessControl.supportsInterface(interfaceId);
    }

    function _authorizeTransferApproval() internal view override {
        _checkRole(OPERATOR_ROLE, _msgSender());
    }

    function _authorizeTransferExecution() internal view override {
        _checkRole(RULE_ENGINE_CONTRACT_ROLE, _msgSender());
    }
}
