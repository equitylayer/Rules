// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {AccessControl} from "OZ/access/AccessControl.sol";
import {Context} from "OZ/utils/Context.sol";
/* ==== Abstract contracts === */
import {AccessControlModuleStandalone} from "../../../modules/AccessControlModuleStandalone.sol";
import {RuleWhitelistBase} from "../abstract/base/RuleWhitelistBase.sol";
import {RuleAddressSet} from "../abstract/RuleAddressSet/RuleAddressSet.sol";
/* ==== CMTAT === */

/**
 * @title Rule Whitelist
 * @notice Manages a whitelist of authorized addresses and enforces whitelist-based transfer restrictions.
 * @dev
 * - Inherits core address management logic from {RuleAddressSet}.
 * - Integrates restriction code logic from {RuleWhitelistShared}.
 * - Implements {IERC1404} to return specific restriction codes for non-whitelisted transfers.
 */
contract RuleWhitelist is RuleWhitelistBase, AccessControlModuleStandalone {
    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/
    /**
     * @param admin Address of the contract (Access Control)
     * @param forwarderIrrevocable Address of the forwarder, required for the gasless support
     */
    constructor(address admin, address forwarderIrrevocable, bool checkSpender_)
        RuleWhitelistBase(forwarderIrrevocable, checkSpender_)
        AccessControlModuleStandalone(admin)
    {
        // no-op
    }

    /* ============  View Functions ============ */

    /**
     * @notice Indicates whether this contract supports a given interface.
     * @param interfaceId The interface identifier, as specified in ERC-165.
     * @return supported True if the interface is supported.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControl, RuleWhitelistBase)
        returns (bool)
    {
        return AccessControl.supportsInterface(interfaceId) || RuleWhitelistBase.supportsInterface(interfaceId);
    }

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    function _authorizeCheckSpenderManager() internal view virtual override {
        _checkRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    function _authorizeAddressListAdd() internal view virtual override {
        _checkRole(ADDRESS_LIST_ADD_ROLE, _msgSender());
    }

    function _authorizeAddressListRemove() internal view virtual override {
        _checkRole(ADDRESS_LIST_REMOVE_ROLE, _msgSender());
    }

    function _msgSender() internal view virtual override(Context, RuleAddressSet) returns (address sender) {
        return super._msgSender();
    }

    function _msgData() internal view virtual override(Context, RuleAddressSet) returns (bytes calldata) {
        return super._msgData();
    }

    function _contextSuffixLength() internal view virtual override(Context, RuleAddressSet) returns (uint256) {
        return super._contextSuffixLength();
    }
}
