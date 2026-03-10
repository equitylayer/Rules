// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {IAccessControl} from "OZ/access/IAccessControl.sol";
import {HelperContract} from "../../HelperContract.sol";
import {RuleERC2980} from "src/rules/validation/deployment/RuleERC2980.sol";

contract RuleERC2980AccessControlTest is Test, HelperContract {
    RuleERC2980 public ruleERC2980;

    address constant WHITELIST_OPERATOR = address(10);
    address constant FROZENLIST_OPERATOR = address(11);

    // Role constants (matching RuleERC2980InvariantStorage)
    bytes32 constant WHITELIST_ADD = keccak256("WHITELIST_ADD_ROLE");
    bytes32 constant WHITELIST_REMOVE = keccak256("WHITELIST_REMOVE_ROLE");
    bytes32 constant FROZENLIST_ADD = keccak256("FROZENLIST_ADD_ROLE");
    bytes32 constant FROZENLIST_REMOVE = keccak256("FROZENLIST_REMOVE_ROLE");

    function setUp() public {
        vm.startPrank(DEFAULT_ADMIN_ADDRESS);
        ruleERC2980 = new RuleERC2980(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS);
        ruleERC2980.grantRole(WHITELIST_ADD, WHITELIST_OPERATOR);
        ruleERC2980.grantRole(WHITELIST_REMOVE, WHITELIST_OPERATOR);
        ruleERC2980.grantRole(FROZENLIST_ADD, FROZENLIST_OPERATOR);
        ruleERC2980.grantRole(FROZENLIST_REMOVE, FROZENLIST_OPERATOR);
        vm.stopPrank();
    }

    /*//////////////////////////////////////////////////////////////
                     WHITELIST — UNAUTHORIZED
    //////////////////////////////////////////////////////////////*/

    function testAddWhitelistAddressUnauthorizedReverts() public {
        vm.prank(ATTACKER);
        vm.expectRevert(
            abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, ATTACKER, WHITELIST_ADD)
        );
        ruleERC2980.addWhitelistAddress(ADDRESS1);
    }

    function testRemoveWhitelistAddressUnauthorizedReverts() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleERC2980.addWhitelistAddress(ADDRESS1);

        vm.prank(ATTACKER);
        vm.expectRevert(
            abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, ATTACKER, WHITELIST_REMOVE)
        );
        ruleERC2980.removeWhitelistAddress(ADDRESS1);
    }

    function testAddWhitelistAddressesUnauthorizedReverts() public {
        address[] memory addrs = new address[](1);
        addrs[0] = ADDRESS1;
        vm.prank(ATTACKER);
        vm.expectRevert(
            abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, ATTACKER, WHITELIST_ADD)
        );
        ruleERC2980.addWhitelistAddresses(addrs);
    }

    function testRemoveWhitelistAddressesUnauthorizedReverts() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleERC2980.addWhitelistAddress(ADDRESS1);

        address[] memory addrs = new address[](1);
        addrs[0] = ADDRESS1;
        vm.prank(ATTACKER);
        vm.expectRevert(
            abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, ATTACKER, WHITELIST_REMOVE)
        );
        ruleERC2980.removeWhitelistAddresses(addrs);
    }

    /*//////////////////////////////////////////////////////////////
                    FROZENLIST — UNAUTHORIZED
    //////////////////////////////////////////////////////////////*/

    function testAddFrozenlistAddressUnauthorizedReverts() public {
        vm.prank(ATTACKER);
        vm.expectRevert(
            abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, ATTACKER, FROZENLIST_ADD)
        );
        ruleERC2980.addFrozenlistAddress(ADDRESS1);
    }

    function testRemoveFrozenlistAddressUnauthorizedReverts() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleERC2980.addFrozenlistAddress(ADDRESS1);

        vm.prank(ATTACKER);
        vm.expectRevert(
            abi.encodeWithSelector(
                IAccessControl.AccessControlUnauthorizedAccount.selector, ATTACKER, FROZENLIST_REMOVE
            )
        );
        ruleERC2980.removeFrozenlistAddress(ADDRESS1);
    }

    function testAddFrozenlistAddressesUnauthorizedReverts() public {
        address[] memory addrs = new address[](1);
        addrs[0] = ADDRESS1;
        vm.prank(ATTACKER);
        vm.expectRevert(
            abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, ATTACKER, FROZENLIST_ADD)
        );
        ruleERC2980.addFrozenlistAddresses(addrs);
    }

    /*//////////////////////////////////////////////////////////////
                       AUTHORIZED OPERATORS
    //////////////////////////////////////////////////////////////*/

    function testWhitelistOperatorCanAdd() public {
        vm.prank(WHITELIST_OPERATOR);
        ruleERC2980.addWhitelistAddress(ADDRESS1);
        assertTrue(ruleERC2980.isWhitelisted(ADDRESS1));
    }

    function testWhitelistOperatorCanRemove() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleERC2980.addWhitelistAddress(ADDRESS1);

        vm.prank(WHITELIST_OPERATOR);
        ruleERC2980.removeWhitelistAddress(ADDRESS1);
        assertFalse(ruleERC2980.isWhitelisted(ADDRESS1));
    }

    function testFrozenlistOperatorCanAdd() public {
        vm.prank(FROZENLIST_OPERATOR);
        ruleERC2980.addFrozenlistAddress(ADDRESS1);
        assertTrue(ruleERC2980.isFrozen(ADDRESS1));
    }

    function testFrozenlistOperatorCanRemove() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleERC2980.addFrozenlistAddress(ADDRESS1);

        vm.prank(FROZENLIST_OPERATOR);
        ruleERC2980.removeFrozenlistAddress(ADDRESS1);
        assertFalse(ruleERC2980.isFrozen(ADDRESS1));
    }

    /*//////////////////////////////////////////////////////////////
                    ADMIN HOLDS ALL ROLES IMPLICITLY
    //////////////////////////////////////////////////////////////*/

    function testAdminCanManageBothLists() public {
        vm.startPrank(DEFAULT_ADMIN_ADDRESS);
        ruleERC2980.addWhitelistAddress(ADDRESS1);
        ruleERC2980.addFrozenlistAddress(ADDRESS3);
        ruleERC2980.removeWhitelistAddress(ADDRESS1);
        ruleERC2980.removeFrozenlistAddress(ADDRESS3);
        vm.stopPrank();
    }

    /*//////////////////////////////////////////////////////////////
                    WHITELIST OPERATOR CANNOT MANAGE FROZENLIST
    //////////////////////////////////////////////////////////////*/

    function testWhitelistOperatorCannotManageFrozenlist() public {
        vm.prank(WHITELIST_OPERATOR);
        vm.expectRevert(
            abi.encodeWithSelector(
                IAccessControl.AccessControlUnauthorizedAccount.selector, WHITELIST_OPERATOR, FROZENLIST_ADD
            )
        );
        ruleERC2980.addFrozenlistAddress(ADDRESS1);
    }

    function testFrozenlistOperatorCannotManageWhitelist() public {
        vm.prank(FROZENLIST_OPERATOR);
        vm.expectRevert(
            abi.encodeWithSelector(
                IAccessControl.AccessControlUnauthorizedAccount.selector, FROZENLIST_OPERATOR, WHITELIST_ADD
            )
        );
        ruleERC2980.addWhitelistAddress(ADDRESS1);
    }
}
