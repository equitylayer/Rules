// SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

import {AccessControl} from "OZ/access/AccessControl.sol";
import {Context} from "OZ/utils/Context.sol";
import {AccessControlModuleStandalone} from "../../modules/AccessControlModuleStandalone.sol";
/* ==== Abtract contracts === */
import {RuleBlacklistBase} from "./abstract/RuleBlacklistBase.sol";
import {RuleAddressSet} from "./abstract/RuleAddressSet/RuleAddressSet.sol";

/**
 * @title a blacklist manager
 */
contract RuleBlacklist is RuleBlacklistBase, AccessControlModuleStandalone {
    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/
    /**
     * @param admin Address of the contract (Access Control)
     * @param forwarderIrrevocable Address of the forwarder, required for the gasless support
     */
    constructor(address admin, address forwarderIrrevocable)
        RuleBlacklistBase(forwarderIrrevocable)
        AccessControlModuleStandalone(admin)
    {}

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControl, RuleBlacklistBase)
        returns (bool)
    {
        return AccessControl.supportsInterface(interfaceId) || RuleBlacklistBase.supportsInterface(interfaceId);
    }

    function _authorizeAddressListAdd() internal view virtual override {
        _checkRole(ADDRESS_LIST_ADD_ROLE, _msgSender());
    }

    function _authorizeAddressListRemove() internal view virtual override {
        _checkRole(ADDRESS_LIST_REMOVE_ROLE, _msgSender());
    }

    function _msgSender() internal view override(Context, RuleAddressSet) returns (address sender) {
        return super._msgSender();
    }

    function _msgData() internal view override(Context, RuleAddressSet) returns (bytes calldata) {
        return super._msgData();
    }

    function _contextSuffixLength() internal view override(Context, RuleAddressSet) returns (uint256) {
        return super._contextSuffixLength();
    }
}
