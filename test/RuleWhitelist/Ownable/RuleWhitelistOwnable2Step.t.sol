// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Ownable2StepTestBase, IOwnable2StepLike} from "../../utils/Ownable2StepTestBase.sol";
import {
    RuleWhitelistOwnable2Step as RuleWhitelistOwnable2StepContract
} from "src/rules/validation/deployment/RuleWhitelistOwnable2Step.sol";

contract RuleWhitelistOwnable2StepTest is Ownable2StepTestBase {
    function _deployOwnable2Step() internal override returns (IOwnable2StepLike, address) {
        address ownerAddr = WHITELIST_OPERATOR_ADDRESS;
        RuleWhitelistOwnable2StepContract rule = new RuleWhitelistOwnable2StepContract(ownerAddr, ZERO_ADDRESS, true);
        return (IOwnable2StepLike(address(rule)), ownerAddr);
    }
}
