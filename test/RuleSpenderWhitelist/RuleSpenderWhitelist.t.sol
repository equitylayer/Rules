// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../HelperContract.sol";
import {RuleSpenderWhitelist} from "src/rules/validation/deployment/RuleSpenderWhitelist.sol";
import {AccessControlModuleStandalone} from "src/modules/AccessControlModuleStandalone.sol";
import {IAccessControl} from "OZ/access/IAccessControl.sol";
import {IRule} from "RuleEngine/interfaces/IRule.sol";
import {RuleSpenderWhitelistHarness} from "src/mocks/harness/RuleSpenderWhitelistHarnesses.sol";

contract RuleSpenderWhitelistTest is Test, HelperContract {
    uint8 internal constant CODE_SPENDER_NOT_WHITELISTED = 66;
    string internal constant TEXT_SPENDER_NOT_WHITELISTED = "SpenderWhitelist: Spender is not whitelisted";

    RuleSpenderWhitelist private rule;
    RuleSpenderWhitelistHarness private harness;

    function setUp() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule = new RuleSpenderWhitelist(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS);
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        harness = new RuleSpenderWhitelistHarness(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS);
    }

    function testRegularTransfersAlwaysAllowed() public {
        assertEq(rule.detectTransferRestriction(ADDRESS1, ADDRESS2, 10), TRANSFER_OK);
        assertTrue(rule.canTransfer(ADDRESS1, ADDRESS2, 10));

        rule.transferred(ADDRESS1, ADDRESS2, 10);
    }

    function testTransferFromRejectedWhenSpenderNotWhitelisted() public {
        assertEq(rule.detectTransferRestrictionFrom(ADDRESS3, ADDRESS1, ADDRESS2, 10), CODE_SPENDER_NOT_WHITELISTED);
        assertFalse(rule.canTransferFrom(ADDRESS3, ADDRESS1, ADDRESS2, 10));

        vm.expectRevert();
        rule.transferred(ADDRESS3, ADDRESS1, ADDRESS2, 10);
    }

    function testTransferFromAllowedWhenSpenderWhitelisted() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.addAddress(ADDRESS3);

        assertEq(rule.detectTransferRestrictionFrom(ADDRESS3, ADDRESS1, ADDRESS2, 10), TRANSFER_OK);
        assertTrue(rule.canTransferFrom(ADDRESS3, ADDRESS1, ADDRESS2, 10));

        rule.transferred(ADDRESS3, ADDRESS1, ADDRESS2, 10);
    }

    function testTokenIdAndContextOverloads() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.addAddress(ADDRESS3);

        assertEq(rule.detectTransferRestriction(ADDRESS1, ADDRESS2, 1, 10), TRANSFER_OK);
        assertEq(rule.detectTransferRestrictionFrom(ADDRESS3, ADDRESS1, ADDRESS2, 1, 10), TRANSFER_OK);
        assertTrue(rule.canTransfer(ADDRESS1, ADDRESS2, 1, 10));
        assertTrue(rule.canTransferFrom(ADDRESS3, ADDRESS1, ADDRESS2, 1, 10));
        rule.transferred(ADDRESS1, ADDRESS2, 1, 10);
        rule.transferred(ADDRESS3, ADDRESS1, ADDRESS2, 1, 10);
    }

    function testCanReturnRestrictionCodeAndMessage() public view {
        assertTrue(rule.canReturnTransferRestrictionCode(CODE_SPENDER_NOT_WHITELISTED));
        assertFalse(rule.canReturnTransferRestrictionCode(CODE_NONEXISTENT));

        assertEq(rule.messageForTransferRestriction(CODE_SPENDER_NOT_WHITELISTED), TEXT_SPENDER_NOT_WHITELISTED);
        assertEq(rule.messageForTransferRestriction(CODE_NONEXISTENT), TEXT_CODE_NOT_FOUND);
    }

    function testOnlyAdminCanManageSpenderWhitelist() public {
        vm.expectRevert();
        vm.prank(ADDRESS1);
        rule.addAddress(ADDRESS3);

        vm.expectRevert();
        vm.prank(ADDRESS1);
        rule.removeAddress(ADDRESS3);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.addAddress(ADDRESS3);
        assertTrue(rule.isAddressListed(ADDRESS3));

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.removeAddress(ADDRESS3);
        assertFalse(rule.isAddressListed(ADDRESS3));
    }

    function testSupportsInterface() public view {
        assertTrue(rule.supportsInterface(type(IAccessControl).interfaceId));
        assertTrue(rule.supportsInterface(type(IRule).interfaceId));
    }

    function testMetaTxOverridesAreReachable() public view {
        assertEq(harness.exposedMsgSender(), address(this));
        assertEq(harness.exposedContextSuffixLength(), 20);
        assertGe(harness.exposedMsgData().length, 4);
    }

    function testCannotDeployWithZeroAdmin() public {
        vm.expectRevert(AccessControlModuleStandalone.AccessControlModuleStandalone_AddressZeroNotAllowed.selector);
        new RuleSpenderWhitelist(ZERO_ADDRESS, ZERO_ADDRESS);
    }
}
