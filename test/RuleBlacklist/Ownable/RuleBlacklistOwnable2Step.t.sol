// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Ownable2StepTestBase, IOwnable2StepLike} from "../../utils/Ownable2StepTestBase.sol";
import {RuleBlacklistOwnable} from "src/rules/validation/RuleBlacklistOwnable.sol";

contract RuleBlacklistOwnable2Step is Ownable2StepTestBase {
    function _deployOwnable2Step() internal override returns (IOwnable2StepLike, address) {
        address ownerAddr = WHITELIST_OPERATOR_ADDRESS;
        RuleBlacklistOwnable rule = new RuleBlacklistOwnable(ownerAddr, ZERO_ADDRESS);
        return (IOwnable2StepLike(address(rule)), ownerAddr);
    }
}
