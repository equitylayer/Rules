// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../HelperContract.sol";

/**
 * @title Integration test between RuleEngine and RuleConditionalTransferLight
 */
contract RuleConditionalTransferLightRuleEngineIntegration is Test, HelperContract {
    function setUp() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleEngineMock = new RuleEngine(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS, ZERO_ADDRESS);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleConditionalTransferLight =
            new RuleConditionalTransferLight(CONDITIONAL_TRANSFER_OPERATOR_ADDRESS, ruleEngineMock);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleEngineMock.addRule(ruleConditionalTransferLight);
    }

    function testDetectRestrictionAndCanTransferWithoutApproval() public {
        uint256 amount = 10;
        resUint8 = ruleEngineMock.detectTransferRestriction(ADDRESS1, ADDRESS2, amount);
        assertEq(resUint8, CODE_TRANSFER_REQUEST_NOT_APPROVED);
        resBool = ruleEngineMock.canTransfer(ADDRESS1, ADDRESS2, amount);
        assertEq(resBool, false);
    }

    function testApproveAndConsumeMultipleTransfers() public {
        uint256 amount = 10;

        vm.prank(CONDITIONAL_TRANSFER_OPERATOR_ADDRESS);
        ruleConditionalTransferLight.approveTransfer(ADDRESS1, ADDRESS2, amount);
        vm.prank(CONDITIONAL_TRANSFER_OPERATOR_ADDRESS);
        ruleConditionalTransferLight.approveTransfer(ADDRESS1, ADDRESS2, amount);

        resUint8 = ruleEngineMock.detectTransferRestriction(ADDRESS1, ADDRESS2, amount);
        assertEq(resUint8, TRANSFER_OK);

        vm.prank(address(ruleEngineMock));
        ruleConditionalTransferLight.transferred(ADDRESS1, ADDRESS2, amount);
        vm.prank(address(ruleEngineMock));
        ruleConditionalTransferLight.transferred(ADDRESS1, ADDRESS2, amount);

        resUint8 = ruleEngineMock.detectTransferRestriction(ADDRESS1, ADDRESS2, amount);
        assertEq(resUint8, CODE_TRANSFER_REQUEST_NOT_APPROVED);

        vm.expectRevert(TransferNotApproved.selector);
        vm.prank(address(ruleEngineMock));
        ruleConditionalTransferLight.transferred(ADDRESS1, ADDRESS2, amount);
    }
}
