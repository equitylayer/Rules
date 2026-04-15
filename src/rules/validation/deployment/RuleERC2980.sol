// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {AccessControlEnumerable} from "OZ/access/extensions/AccessControlEnumerable.sol";
import {Context} from "OZ/utils/Context.sol";
/* ==== Abstract contracts === */
import {AccessControlModuleStandalone} from "../../../modules/AccessControlModuleStandalone.sol";
import {RuleERC2980Base} from "../abstract/base/RuleERC2980Base.sol";

/**
 * @title RuleERC2980
 * @notice ERC-2980 Swiss Compliant transfer rule combining a whitelist and a frozenlist.
 * @dev
 * - Whitelist: only whitelisted addresses may receive tokens.
 *   Senders do not need to be whitelisted.
 * - Frozenlist: frozen addresses are blocked from both sending and receiving.
 *   Frozenlist check takes priority over the whitelist check.
 *
 * Access control uses {AccessControlModuleStandalone}:
 * - `WHITELIST_ADD_ROLE`    — may add addresses to the whitelist.
 * - `WHITELIST_REMOVE_ROLE` — may remove addresses from the whitelist.
 * - `FROZENLIST_ADD_ROLE`   — may add addresses to the frozenlist.
 * - `FROZENLIST_REMOVE_ROLE`— may remove addresses from the frozenlist.
 * - `DEFAULT_ADMIN_ROLE`    — implicitly holds all roles.
 *
 * Restriction codes:
 * - 60: sender is frozen
 * - 61: recipient is frozen
 * - 62: spender is frozen
 * - 63: recipient is not whitelisted
 */
contract RuleERC2980 is RuleERC2980Base, AccessControlModuleStandalone {
    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    /**
     * @param admin Address that receives `DEFAULT_ADMIN_ROLE` (implicitly holds all roles).
     * @param forwarderIrrevocable Address of the ERC-2771 forwarder for meta-transactions.
     * @param allowBurn If true, whitelists `address(0)` at deployment to allow burn/redemption flows.
     */
    constructor(address admin, address forwarderIrrevocable, bool allowBurn)
        RuleERC2980Base(forwarderIrrevocable, allowBurn)
        AccessControlModuleStandalone(admin)
    {}

    /*//////////////////////////////////////////////////////////////
                           PUBLIC FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControlEnumerable, RuleERC2980Base)
        returns (bool)
    {
        return AccessControlEnumerable.supportsInterface(interfaceId) || RuleERC2980Base.supportsInterface(interfaceId);
    }

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    function _authorizeWhitelistAdd() internal view virtual override onlyRole(WHITELIST_ADD_ROLE) {}

    function _authorizeWhitelistRemove() internal view virtual override onlyRole(WHITELIST_REMOVE_ROLE) {}

    function _authorizeFrozenlistAdd() internal view virtual override onlyRole(FROZENLIST_ADD_ROLE) {}

    function _authorizeFrozenlistRemove() internal view virtual override onlyRole(FROZENLIST_REMOVE_ROLE) {}

    /*//////////////////////////////////////////////////////////////
                        INTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function _msgSender() internal view virtual override(Context, RuleERC2980Base) returns (address sender) {
        return super._msgSender();
    }

    function _msgData() internal view virtual override(Context, RuleERC2980Base) returns (bytes calldata) {
        return super._msgData();
    }

    function _contextSuffixLength() internal view virtual override(Context, RuleERC2980Base) returns (uint256) {
        return super._contextSuffixLength();
    }
}
