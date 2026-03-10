// SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== OpenZeppelin === */
import {AccessControl} from "OZ/access/AccessControl.sol";
import {AccessControlEnumerable} from "OZ/access/extensions/AccessControlEnumerable.sol";
import {Context} from "OZ/utils/Context.sol";
/* ==== Abstract contracts === */
import {AccessControlModuleStandalone} from "../../../modules/AccessControlModuleStandalone.sol";
import {RuleWhitelistWrapperBase} from "../abstract/base/RuleWhitelistWrapperBase.sol";

/**
 * @title Wrapper to call several different whitelist rules
 */
contract RuleWhitelistWrapper is RuleWhitelistWrapperBase, AccessControlModuleStandalone {
    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/
    /**
     * @param admin Address of the contract (Access Control)
     * @param forwarderIrrevocable Address of the forwarder, required for the gasless support
     */
    constructor(address admin, address forwarderIrrevocable, bool checkSpender_)
        RuleWhitelistWrapperBase(forwarderIrrevocable, checkSpender_)
        AccessControlModuleStandalone(admin)
    {}

    /* ============  Access control ============ */

    /**
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(bytes32 role, address account)
        public
        view
        virtual
        override(AccessControl, AccessControlModuleStandalone)
        returns (bool)
    {
        return AccessControlModuleStandalone.hasRole(role, account);
    }

    function _authorizeCheckSpenderManager() internal virtual override onlyRole(DEFAULT_ADMIN_ROLE) {}

    /**
     * @dev Restrict rules management to the dedicated role.
     */
    function _onlyRulesManager() internal virtual override onlyRole(RULES_MANAGEMENT_ROLE) {}

    /*//////////////////////////////////////////////////////////////
                           ERC-2771
    //////////////////////////////////////////////////////////////*/

    function _msgSender() internal view virtual override(RuleWhitelistWrapperBase, Context) returns (address sender) {
        return RuleWhitelistWrapperBase._msgSender();
    }

    function _msgData() internal view virtual override(RuleWhitelistWrapperBase, Context) returns (bytes calldata) {
        return RuleWhitelistWrapperBase._msgData();
    }

    function _contextSuffixLength()
        internal
        view
        virtual
        override(RuleWhitelistWrapperBase, Context)
        returns (uint256)
    {
        return RuleWhitelistWrapperBase._contextSuffixLength();
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControlEnumerable, RuleWhitelistWrapperBase)
        returns (bool)
    {
        return RuleWhitelistWrapperBase.supportsInterface(interfaceId)
            || AccessControlEnumerable.supportsInterface(interfaceId);
    }

    function _grantRole(bytes32 role, address account)
        internal
        virtual
        override(AccessControl, AccessControlEnumerable)
        returns (bool)
    {
        return AccessControlEnumerable._grantRole(role, account);
    }

    function _revokeRole(bytes32 role, address account)
        internal
        virtual
        override(AccessControl, AccessControlEnumerable)
        returns (bool)
    {
        return AccessControlEnumerable._revokeRole(role, account);
    }
}
