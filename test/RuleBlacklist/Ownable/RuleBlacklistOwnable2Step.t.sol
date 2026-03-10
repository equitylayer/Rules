// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Ownable2StepTestBase, IOwnable2StepLike} from "../../utils/Ownable2StepTestBase.sol";
import {
    RuleBlacklistOwnable2Step as RuleBlacklistOwnable2StepContract
} from "src/rules/validation/deployment/RuleBlacklistOwnable2Step.sol";

contract RuleBlacklistOwnable2StepTest is Ownable2StepTestBase {
    function _deployOwnable2Step() internal override returns (IOwnable2StepLike, address) {
        address ownerAddr = WHITELIST_OPERATOR_ADDRESS;
        RuleBlacklistOwnable2StepContract rule = new RuleBlacklistOwnable2StepContract(ownerAddr, ZERO_ADDRESS);
        return (IOwnable2StepLike(address(rule)), ownerAddr);
    }
}
