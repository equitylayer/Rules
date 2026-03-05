// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../HelperContract.sol";
import {RuleConditionalTransferLight} from "src/rules/operation/RuleConditionalTransferLight.sol";

contract RuleConditionalTransferLightUnit is Test, HelperContract {
    RuleConditionalTransferLight private rule;

    function setUp() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule = new RuleConditionalTransferLight(DEFAULT_ADMIN_ADDRESS);
        rule.bindToken(ADDRESS3);
    }

    function testApproveTransfer_OnlyOperator() public {
        vm.expectRevert();
        vm.prank(ADDRESS1);
        rule.approveTransfer(ADDRESS1, ADDRESS2, 10);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.approveTransfer(ADDRESS1, ADDRESS2, 10);
        assertEq(rule.approvedCount(ADDRESS1, ADDRESS2, 10), 1);
    }

    function testCancelTransferApproval_OnlyOperator() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.approveTransfer(ADDRESS1, ADDRESS2, 10);

        vm.expectRevert();
        vm.prank(ADDRESS1);
        rule.cancelTransferApproval(ADDRESS1, ADDRESS2, 10);
    }

    function testTransferred_OnlyBoundToken() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.approveTransfer(ADDRESS1, ADDRESS2, 10);

        vm.expectRevert();
        vm.prank(ADDRESS1);
        rule.transferred(ADDRESS1, ADDRESS2, 10);

        vm.prank(ADDRESS3);
        rule.transferred(ADDRESS1, ADDRESS2, 10);
    }

    function testTransferred_RevertsWhenNotApproved() public {
        vm.expectRevert(TransferNotApproved.selector);
        vm.prank(ADDRESS3);
        rule.transferred(ADDRESS1, ADDRESS2, 10);
    }

    function testDetectRestrictionAndCanTransferWhenApproved() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.approveTransfer(ADDRESS1, ADDRESS2, 10);

        resUint8 = rule.detectTransferRestriction(ADDRESS1, ADDRESS2, 10);
        assertEq(resUint8, TRANSFER_OK);
        resBool = rule.canTransfer(ADDRESS1, ADDRESS2, 10);
        assertEq(resBool, true);
    }
}
