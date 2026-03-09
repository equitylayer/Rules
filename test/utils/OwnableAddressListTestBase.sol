// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../HelperContract.sol";
import {IAddressList} from "src/rules/interfaces/IAddressList.sol";

/**
 * @title Shared tests for Ownable address-list rules
 */
abstract contract OwnableAddressListTestBase is Test, HelperContract {
    // OpenZeppelin Ownable error
    error OwnableUnauthorizedAccount(address account);

    IAddressList internal addressList;
    address internal owner;

    function _deployAddressList() internal virtual returns (IAddressList, address);

    function setUp() public virtual {
        (addressList, owner) = _deployAddressList();
    }

    function testOwnerCanAddAndRemove() public {
        vm.prank(owner);
        addressList.addAddress(ADDRESS1);
        assertEq(addressList.isAddressListed(ADDRESS1), true);

        vm.prank(owner);
        addressList.removeAddress(ADDRESS1);
        assertEq(addressList.isAddressListed(ADDRESS1), false);
    }

    function testNonOwnerCannotAddOrRemove() public {
        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount.selector, ATTACKER));
        vm.prank(ATTACKER);
        addressList.addAddress(ADDRESS1);

        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount.selector, ATTACKER));
        vm.prank(ATTACKER);
        addressList.removeAddress(ADDRESS1);
    }
}
