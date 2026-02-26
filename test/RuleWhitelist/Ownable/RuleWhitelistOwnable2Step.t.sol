// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Ownable2StepTestBase, IOwnable2StepLike} from "../../utils/Ownable2StepTestBase.sol";
import {RuleWhitelistOwnable} from "src/rules/validation/RuleWhitelistOwnable.sol";

contract RuleWhitelistOwnable2Step is Ownable2StepTestBase {
    function _deployOwnable2Step() internal override returns (IOwnable2StepLike, address) {
        address ownerAddr = WHITELIST_OPERATOR_ADDRESS;
        RuleWhitelistOwnable rule = new RuleWhitelistOwnable(ownerAddr, ZERO_ADDRESS, true);
        return (IOwnable2StepLike(address(rule)), ownerAddr);
    }
}
