// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

/* ==== OpenZeppelin === */
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

/**
 * @title RuleERC2980Internal
 * @notice Internal storage and helpers for two independent address sets:
 *         a whitelist and a frozenlist, following the same pattern as {RuleAddressSetInternal}.
 * @dev
 * - Whitelist: only whitelisted addresses may receive tokens.
 * - Frozenlist: frozen addresses may neither send nor receive tokens.
 * - Batch operations do not revert when individual entries are already present or absent.
 */
abstract contract RuleERC2980Internal {
    using EnumerableSet for EnumerableSet.AddressSet;

    /*//////////////////////////////////////////////////////////////
                             STATE VARIABLES
    //////////////////////////////////////////////////////////////*/

    /// @dev Addresses allowed to receive tokens.
    EnumerableSet.AddressSet private _whitelist;

    /// @dev Addresses completely blocked from sending and receiving tokens.
    EnumerableSet.AddressSet private _frozenlist;

    /*//////////////////////////////////////////////////////////////
                          WHITELIST — INTERNAL
    //////////////////////////////////////////////////////////////*/

    function _addWhitelistAddresses(address[] calldata addressesToAdd)
        internal
        returns (uint256 added, uint256 skipped)
    {
        for (uint256 i = 0; i < addressesToAdd.length; ++i) {
            if (_whitelist.add(addressesToAdd[i])) {
                added += 1;
            } else {
                skipped += 1;
            }
        }
    }

    function _removeWhitelistAddresses(address[] calldata addressesToRemove)
        internal
        returns (uint256 removed, uint256 skipped)
    {
        for (uint256 i = 0; i < addressesToRemove.length; ++i) {
            if (_whitelist.remove(addressesToRemove[i])) {
                removed += 1;
            } else {
                skipped += 1;
            }
        }
    }

    function _addWhitelistAddress(address targetAddress) internal virtual {
        _whitelist.add(targetAddress);
    }

    function _removeWhitelistAddress(address targetAddress) internal virtual {
        _whitelist.remove(targetAddress);
    }

    function _isWhitelisted(address targetAddress) internal view virtual returns (bool) {
        return _whitelist.contains(targetAddress);
    }

    function _whitelistCount() internal view virtual returns (uint256) {
        return _whitelist.length();
    }

    /*//////////////////////////////////////////////////////////////
                         FROZENLIST — INTERNAL
    //////////////////////////////////////////////////////////////*/

    function _addFrozenlistAddresses(address[] calldata addressesToAdd)
        internal
        returns (uint256 added, uint256 skipped)
    {
        for (uint256 i = 0; i < addressesToAdd.length; ++i) {
            if (_frozenlist.add(addressesToAdd[i])) {
                added += 1;
            } else {
                skipped += 1;
            }
        }
    }

    function _removeFrozenlistAddresses(address[] calldata addressesToRemove)
        internal
        returns (uint256 removed, uint256 skipped)
    {
        for (uint256 i = 0; i < addressesToRemove.length; ++i) {
            if (_frozenlist.remove(addressesToRemove[i])) {
                removed += 1;
            } else {
                skipped += 1;
            }
        }
    }

    function _addFrozenlistAddress(address targetAddress) internal virtual {
        _frozenlist.add(targetAddress);
    }

    function _removeFrozenlistAddress(address targetAddress) internal virtual {
        _frozenlist.remove(targetAddress);
    }

    function _isFrozen(address targetAddress) internal view virtual returns (bool) {
        return _frozenlist.contains(targetAddress);
    }

    function _frozenlistCount() internal view virtual returns (uint256) {
        return _frozenlist.length();
    }
}
