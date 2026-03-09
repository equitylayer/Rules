// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../HelperContract.sol";

interface IAccessControlEnumerableLike {
    function getRoleMember(bytes32 role, uint256 index) external view returns (address);
    function getRoleMemberCount(bytes32 role) external view returns (uint256);
    function hasRole(bytes32 role, address account) external view returns (bool);
}

/**
 * @title Shared tests for AccessControlEnumerable role members
 */
abstract contract AccessControlEnumerableTestBase is Test, HelperContract {
    bytes32 internal constant DEFAULT_ADMIN_ROLE = 0x00;
    bytes32 internal constant RULES_MANAGEMENT_ROLE = keccak256("RULES_MANAGEMENT_ROLE");
    IAccessControlEnumerableLike internal accessControl;
    address internal admin;

    function _deployAccessControl() internal virtual returns (IAccessControlEnumerableLike, address);

    function setUp() public virtual {
        (accessControl, admin) = _deployAccessControl();
    }

    function _assertRoleMembers(bytes32 role, address[] memory expected) internal {
        uint256 count = accessControl.getRoleMemberCount(role);
        assertEq(count, expected.length);
        if (expected.length == 0) {
            return;
        }
        for (uint256 i = 0; i < expected.length; ++i) {
            assertEq(accessControl.getRoleMember(role, i), expected[i]);
            assertTrue(accessControl.hasRole(role, expected[i]));
        }
    }
}
