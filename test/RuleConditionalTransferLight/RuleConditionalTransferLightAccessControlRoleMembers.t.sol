// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {AccessControlEnumerableTestBase, IAccessControlEnumerableLike} from "../utils/AccessControlEnumerableTestBase.sol";
import {RuleConditionalTransferLight} from "src/rules/operation/RuleConditionalTransferLight.sol";

contract RuleConditionalTransferLightAccessControlRoleMembers is AccessControlEnumerableTestBase {
    function _deployAccessControl() internal override returns (IAccessControlEnumerableLike, address) {
        address adminAddr = DEFAULT_ADMIN_ADDRESS;
        RuleConditionalTransferLight rule = new RuleConditionalTransferLight(adminAddr);
        return (IAccessControlEnumerableLike(address(rule)), adminAddr);
    }

    function testRoleMembers() public {
        address[] memory singleAdmin = new address[](1);
        singleAdmin[0] = admin;
        address[] memory empty = new address[](0);

        _assertRoleMembers(DEFAULT_ADMIN_ROLE, singleAdmin);
        _assertRoleMembers(OPERATOR_ROLE, empty);
    }
}
