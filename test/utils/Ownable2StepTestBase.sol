// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import "../HelperContract.sol";

interface IOwnable2StepLike {
    function owner() external view returns (address);
    function pendingOwner() external view returns (address);
    function transferOwnership(address newOwner) external;
    function acceptOwnership() external;
}

/**
 * @title Shared tests for Ownable2Step contracts
 */
abstract contract Ownable2StepTestBase is Test, HelperContract {
    // OpenZeppelin Ownable error
    error OwnableUnauthorizedAccount(address account);

    IOwnable2StepLike internal ownable;
    address internal owner;

    function _deployOwnable2Step() internal virtual returns (IOwnable2StepLike, address);

    function setUp() public virtual {
        (ownable, owner) = _deployOwnable2Step();
    }

    function testOnlyOwnerCanTransferOwnership() public {
        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount.selector, ATTACKER));
        vm.prank(ATTACKER);
        ownable.transferOwnership(ADDRESS2);

        vm.prank(owner);
        ownable.transferOwnership(ADDRESS2);
        assertEq(ownable.pendingOwner(), ADDRESS2);
        assertEq(ownable.owner(), owner);
    }

    function testPendingOwnerMustAccept() public {
        vm.prank(owner);
        ownable.transferOwnership(ADDRESS2);

        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount.selector, ATTACKER));
        vm.prank(ATTACKER);
        ownable.acceptOwnership();

        vm.prank(ADDRESS2);
        ownable.acceptOwnership();
        assertEq(ownable.owner(), ADDRESS2);
        assertEq(ownable.pendingOwner(), address(0));
    }
}
