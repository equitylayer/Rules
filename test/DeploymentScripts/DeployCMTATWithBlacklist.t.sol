// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {CMTATStandalone} from "CMTAT/deployment/CMTATStandalone.sol";
import {RuleBlacklist} from "src/rules/validation/deployment/RuleBlacklist.sol";
import {DeployCMTATWithBlacklist} from "script/DeployCMTATWithBlacklist.s.sol";

contract DeployCMTATWithBlacklistTest is Test {
    function testDeployCMTATWithBlacklist() public {
        DeployCMTATWithBlacklist script = new DeployCMTATWithBlacklist();
        (CMTATStandalone token, RuleBlacklist rule) = _deploy(script);

        assertEq(address(token.ruleEngine()), address(rule));
    }

    function _deploy(DeployCMTATWithBlacklist script) internal returns (CMTATStandalone token, RuleBlacklist rule) {
        (token, rule) = script.deploy(address(1), address(0));
    }
}
