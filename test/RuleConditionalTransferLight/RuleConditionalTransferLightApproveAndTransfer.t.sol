// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../HelperContract.sol";
import {RuleConditionalTransferLight} from "src/rules/operation/RuleConditionalTransferLight.sol";
import {MockERC20WithTransferContext} from "../utils/MockERC20WithTransferContext.sol";
import {IRuleEngine} from "CMTAT/interfaces/engine/IRuleEngine.sol";

contract RuleConditionalTransferLightApproveAndTransfer is Test, HelperContract {
    RuleConditionalTransferLight private rule;
    MockERC20WithTransferContext private token;

    function setUp() public {
        token = new MockERC20WithTransferContext("Mock", "MOCK");

        vm.startPrank(DEFAULT_ADMIN_ADDRESS);
        rule = new RuleConditionalTransferLight(DEFAULT_ADMIN_ADDRESS, IRuleEngine(address(0)));
        rule.grantRole(rule.RULE_ENGINE_CONTRACT_ROLE(), address(token));
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
}
