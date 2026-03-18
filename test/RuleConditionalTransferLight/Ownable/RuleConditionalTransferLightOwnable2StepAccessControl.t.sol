// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../../HelperContract.sol";
import {
    RuleConditionalTransferLightOwnable2Step
} from "src/rules/operation/RuleConditionalTransferLightOwnable2Step.sol";

contract RuleConditionalTransferLightOwnable2StepAccessControl is Test, HelperContract {
    // OpenZeppelin Ownable error
    error OwnableUnauthorizedAccount(address account);

    RuleConditionalTransferLightOwnable2Step private rule;

    function setUp() public {
        rule = new RuleConditionalTransferLightOwnable2Step(CONDITIONAL_TRANSFER_OPERATOR_ADDRESS);
        vm.prank(CONDITIONAL_TRANSFER_OPERATOR_ADDRESS);
        rule.bindToken(ADDRESS3);
    }

    function testOwnerCanApproveAndExecuteTransfer() public {
        vm.prank(CONDITIONAL_TRANSFER_OPERATOR_ADDRESS);
        rule.approveTransfer(ADDRESS1, ADDRESS2, 10);
        assertEq(rule.approvedCount(ADDRESS1, ADDRESS2, 10), 1);

        vm.prank(ADDRESS3);
        rule.transferred(ADDRESS1, ADDRESS2, 10);
        assertEq(rule.approvedCount(ADDRESS1, ADDRESS2, 10), 0);
    }

    function testNonOwnerCannotApproveOrExecuteTransfer() public {
        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount.selector, ATTACKER));
        vm.prank(ATTACKER);
        rule.approveTransfer(ADDRESS1, ADDRESS2, 10);

        vm.prank(CONDITIONAL_TRANSFER_OPERATOR_ADDRESS);
        rule.approveTransfer(ADDRESS1, ADDRESS2, 10);

        vm.expectRevert(
            abi.encodeWithSelector(RuleConditionalTransferLight_TransferExecutorUnauthorized.selector, ATTACKER)
        );
        vm.prank(ATTACKER);
        rule.transferred(ADDRESS1, ADDRESS2, 10);
    }
}
