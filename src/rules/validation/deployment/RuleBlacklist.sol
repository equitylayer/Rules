// SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

import {AccessControlEnumerable} from "OZ/access/extensions/AccessControlEnumerable.sol";
import {Context} from "OZ/utils/Context.sol";
import {AccessControlModuleStandalone} from "../../../modules/AccessControlModuleStandalone.sol";
/* ==== Abstract contracts === */
import {RuleBlacklistBase} from "../abstract/base/RuleBlacklistBase.sol";
import {RuleAddressSet} from "../abstract/RuleAddressSet/RuleAddressSet.sol";

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

    /*//////////////////////////////////////////////////////////////
                          PUBLIC FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControlEnumerable, RuleBlacklistBase)
        returns (bool)
    {
        return AccessControlEnumerable.supportsInterface(interfaceId)
            || RuleBlacklistBase.supportsInterface(interfaceId);
    }

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    function _authorizeAddressListAdd() internal view virtual override onlyRole(ADDRESS_LIST_ADD_ROLE) {}

    function _authorizeAddressListRemove() internal view virtual override onlyRole(ADDRESS_LIST_REMOVE_ROLE) {}

    /*//////////////////////////////////////////////////////////////
                        INTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

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
