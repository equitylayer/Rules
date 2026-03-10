// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../HelperContract.sol";
import {RuleWhitelist} from "src/rules/validation/deployment/RuleWhitelist.sol";
import {RuleConditionalTransferLight} from "src/rules/operation/RuleConditionalTransferLight.sol";
import {MockERC20WithTransferContext} from "src/mocks/MockERC20WithTransferContext.sol";

contract TransferContextTest is Test, HelperContract {
    MockERC20WithTransferContext private token;

    function setUp() public {
        token = new MockERC20WithTransferContext("Mock", "MOCK");
    }

    function _deployWhitelistRule() internal returns (RuleWhitelist) {
        vm.prank(WHITELIST_OPERATOR_ADDRESS);
        RuleWhitelist rule = new RuleWhitelist(WHITELIST_OPERATOR_ADDRESS, ZERO_ADDRESS, false);
        vm.prank(WHITELIST_OPERATOR_ADDRESS);
        rule.addAddress(ADDRESS1);
        vm.prank(WHITELIST_OPERATOR_ADDRESS);
        rule.addAddress(ADDRESS2);
        return rule;
    }

    function testTransferContextFungibleWhitelist() public {
        RuleWhitelist rule = _deployWhitelistRule();
        token.setRule(address(rule));
        token.mint(ADDRESS1, 100);

        vm.prank(ADDRESS1);
        token.transferWithContext(ADDRESS2, 10, true, 0);
    }

    function testTransferContextWithTokenIdWhitelist() public {
        RuleWhitelist rule = _deployWhitelistRule();
        token.setRule(address(rule));
        token.mint(ADDRESS1, 100);

        vm.prank(ADDRESS1);
        token.transferWithContext(ADDRESS2, 10, false, 1);
    }

    function testTransferContextFungibleConditionalTransferLight() public {
        vm.startPrank(DEFAULT_ADMIN_ADDRESS);
        ruleConditionalTransferLight = new RuleConditionalTransferLight(DEFAULT_ADMIN_ADDRESS);
        ruleConditionalTransferLight.bindToken(address(token));
        ruleConditionalTransferLight.approveTransfer(ADDRESS1, ADDRESS2, 10);
        vm.stopPrank();

        token.setRule(address(ruleConditionalTransferLight));
        token.mint(ADDRESS1, 100);

        vm.prank(ADDRESS1);
        token.transferWithContext(ADDRESS2, 10, true, 0);
    }

    function testTransferContextFungibleConditionalTransferLightTransferFrom() public {
        vm.startPrank(DEFAULT_ADMIN_ADDRESS);
        ruleConditionalTransferLight = new RuleConditionalTransferLight(DEFAULT_ADMIN_ADDRESS);
        ruleConditionalTransferLight.bindToken(address(token));
        ruleConditionalTransferLight.approveTransfer(ADDRESS1, ADDRESS2, 10);
        vm.stopPrank();

        token.setRule(address(ruleConditionalTransferLight));
        token.mint(ADDRESS1, 100);

        vm.prank(ADDRESS1);
        token.approve(ADDRESS3, 10);

        vm.prank(ADDRESS3);
        token.transferFromWithContext(ADDRESS1, ADDRESS2, 10, true, 0);
    }

    function testTransferFromContextFungibleWhitelist() public {
        RuleWhitelist rule = _deployWhitelistRule();
        token.setRule(address(rule));
        token.mint(ADDRESS1, 100);

        vm.prank(ADDRESS1);
        token.approve(ADDRESS3, 10);

        vm.prank(ADDRESS3);
        token.transferFromWithContext(ADDRESS1, ADDRESS2, 10, true, 0);
    }

    function testTransferFromContextWithTokenIdWhitelist() public {
        RuleWhitelist rule = _deployWhitelistRule();
        token.setRule(address(rule));
        token.mint(ADDRESS1, 100);

        vm.prank(ADDRESS1);
        token.approve(ADDRESS3, 10);

        vm.prank(ADDRESS3);
        token.transferFromWithContext(ADDRESS1, ADDRESS2, 10, false, 1);
    }
}
