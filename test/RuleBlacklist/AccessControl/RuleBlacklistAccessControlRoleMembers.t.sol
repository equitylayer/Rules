// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {
    AccessControlEnumerableTestBase,
    IAccessControlEnumerableLike
} from "../../utils/AccessControlEnumerableTestBase.sol";
import {RuleBlacklist} from "src/rules/validation/deployment/RuleBlacklist.sol";

contract RuleBlacklistAccessControlRoleMembers is AccessControlEnumerableTestBase {
    function _deployAccessControl() internal override returns (IAccessControlEnumerableLike, address) {
        address adminAddr = DEFAULT_ADMIN_ADDRESS;
        RuleBlacklist rule = new RuleBlacklist(adminAddr, ZERO_ADDRESS);
        return (IAccessControlEnumerableLike(address(rule)), adminAddr);
    }

    function testRoleMembers() public {
        address[] memory singleAdmin = new address[](1);
        singleAdmin[0] = admin;

        _assertRoleMembers(DEFAULT_ADMIN_ROLE, singleAdmin);
        _assertRoleMembers(ADDRESS_LIST_ADD_ROLE, new address[](0));
        _assertRoleMembers(ADDRESS_LIST_REMOVE_ROLE, new address[](0));
    }
}
