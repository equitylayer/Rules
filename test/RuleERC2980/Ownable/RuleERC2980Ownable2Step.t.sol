// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Ownable2StepTestBase, IOwnable2StepLike} from "../../utils/Ownable2StepTestBase.sol";
import {
    RuleERC2980Ownable2Step as RuleERC2980Ownable2StepContract
} from "src/rules/validation/deployment/RuleERC2980Ownable2Step.sol";

contract RuleERC2980Ownable2StepTest is Ownable2StepTestBase {
    function _deployOwnable2Step() internal override returns (IOwnable2StepLike, address) {
        address ownerAddr = WHITELIST_OPERATOR_ADDRESS;
        RuleERC2980Ownable2StepContract rule = new RuleERC2980Ownable2StepContract(ownerAddr, ZERO_ADDRESS, false);
        return (IOwnable2StepLike(address(rule)), ownerAddr);
    }
}
