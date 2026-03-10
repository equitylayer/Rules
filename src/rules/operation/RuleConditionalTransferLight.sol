// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {AccessControlEnumerable} from "OZ/access/extensions/AccessControlEnumerable.sol";
import {IERC165} from "OZ/utils/introspection/IERC165.sol";
import {IRule} from "RuleEngine/interfaces/IRule.sol";
import {RuleInterfaceId} from "RuleEngine/modules/library/RuleInterfaceId.sol";
import {AccessControlModuleStandalone} from "../../modules/AccessControlModuleStandalone.sol";
import {ERC3643ComplianceModule} from "RuleEngine/modules/ERC3643ComplianceModule.sol";
import {RuleConditionalTransferLightBase} from "./abstract/RuleConditionalTransferLightBase.sol";

/**
 * @title ConditionalTransferLight
 * @dev Requires operator approval for each transfer. Same transfer (from, to, value)
 *      can be approved multiple times to allow repeated transfers.
 */
contract RuleConditionalTransferLight is
    AccessControlModuleStandalone,
    ERC3643ComplianceModule,
    RuleConditionalTransferLightBase
{
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
        return interfaceId == RuleInterfaceId.IRULE_INTERFACE_ID || interfaceId == type(IRule).interfaceId
            || AccessControlEnumerable.supportsInterface(interfaceId);
    }

    function created(address to, uint256 value) external onlyBoundToken {
        _transferred(address(0), to, value);
    }

    function destroyed(address from, uint256 value) external onlyBoundToken {
        _transferred(from, address(0), value);
    }

    function _authorizeTransferApproval() internal view virtual override onlyRole(OPERATOR_ROLE) {}

    function _authorizeTransferExecution() internal view virtual override {
        require(
            isTokenBound(_msgSender()),
            RuleConditionalTransferLight_TransferExecutorUnauthorized(_msgSender())
        );
    }

    function _onlyComplianceManager() internal virtual override onlyRole(COMPLIANCE_MANAGER_ROLE) {}
}
