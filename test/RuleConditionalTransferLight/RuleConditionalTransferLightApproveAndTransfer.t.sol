// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../HelperContract.sol";
import {RuleConditionalTransferLight} from "src/rules/operation/RuleConditionalTransferLight.sol";
import {MockERC20WithTransferContext} from "../utils/MockERC20WithTransferContext.sol";

contract MockERC20TransferFromFalse {
    mapping(address => mapping(address => uint256)) private _allowances;

    function setAllowance(address owner, address spender, uint256 value) external {
        _allowances[owner][spender] = value;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }

    function transferFrom(address, address, uint256) external pure returns (bool) {
        return false;
    }
}

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
