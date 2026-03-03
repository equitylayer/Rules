// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../../HelperContract.sol";
import {RuleWhitelistOwnable} from "src/rules/validation/deployment/RuleWhitelistOwnable.sol";

contract RuleWhitelistOwnableCheckSpender is Test, HelperContract {
    error OwnableUnauthorizedAccount(address account);

    RuleWhitelistOwnable rule;

    function setUp() public {
        rule = new RuleWhitelistOwnable(WHITELIST_OPERATOR_ADDRESS, ZERO_ADDRESS, true);
    }

    function testOnlyOwnerCanSetCheckSpender() public {
        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount.selector, ATTACKER));
        vm.prank(ATTACKER);
        rule.setCheckSpender(false);

        vm.prank(WHITELIST_OPERATOR_ADDRESS);
        rule.setCheckSpender(false);
    }
}
