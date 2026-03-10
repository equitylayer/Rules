// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../HelperContract.sol";
import {RuleConditionalTransferLight} from "src/rules/operation/RuleConditionalTransferLight.sol";
import {MockERC20WithTransferContext} from "src/mocks/MockERC20WithTransferContext.sol";
import {MockERC20TransferFromFalse} from "src/mocks/MockERC20TransferFromFalse.sol";

contract RuleConditionalTransferLightApproveAndTransfer is Test, HelperContract {
    RuleConditionalTransferLight private rule;
    MockERC20WithTransferContext private token;

    function setUp() public {
        token = new MockERC20WithTransferContext("Mock", "MOCK");

        vm.startPrank(DEFAULT_ADMIN_ADDRESS);
        rule = new RuleConditionalTransferLight(DEFAULT_ADMIN_ADDRESS);
        rule.bindToken(address(token));
        vm.stopPrank();

        token.setRule(address(rule));
        token.mint(ADDRESS1, 100);
    }

    function testApproveAndTransferIfAllowed() public {
        vm.prank(ADDRESS1);
        token.approve(address(rule), 10);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.approveAndTransferIfAllowed(address(token), ADDRESS1, ADDRESS2, 10);

        assertEq(token.balanceOf(ADDRESS1), 90);
        assertEq(token.balanceOf(ADDRESS2), 10);
        assertEq(rule.approvedCount(ADDRESS1, ADDRESS2, 10), 0);
    }

    function testApproveAndTransferIfAllowedRevertsOnZeroToken() public {
        vm.expectRevert(RuleConditionalTransferLight_TokenAddressZeroNotAllowed.selector);
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.approveAndTransferIfAllowed(ZERO_ADDRESS, ADDRESS1, ADDRESS2, 10);
    }

    function testApproveAndTransferIfAllowedRevertsOnInsufficientAllowance() public {
        vm.expectRevert(
            abi.encodeWithSelector(
                RuleConditionalTransferLight_InsufficientAllowance.selector, address(token), ADDRESS1, 0, 10
            )
        );
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.approveAndTransferIfAllowed(address(token), ADDRESS1, ADDRESS2, 10);
    }

    function testApproveAndTransferIfAllowedRevertsOnTransferFailure() public {
        MockERC20TransferFromFalse failingToken = new MockERC20TransferFromFalse();
        failingToken.setAllowance(ADDRESS1, address(rule), 10);

        vm.expectRevert(RuleConditionalTransferLight_TransferFailed.selector);
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.approveAndTransferIfAllowed(address(failingToken), ADDRESS1, ADDRESS2, 10);
    }
}
