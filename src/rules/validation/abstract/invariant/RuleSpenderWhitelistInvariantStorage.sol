// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {RuleCommonInvariantStorage} from "./RuleCommonInvariantStorage.sol";

abstract contract RuleSpenderWhitelistInvariantStorage is RuleCommonInvariantStorage {
    // It is very important that each rule uses an unique code
    uint8 public constant CODE_ADDRESS_SPENDER_NOT_WHITELISTED = 66;
    string constant TEXT_ADDRESS_SPENDER_NOT_WHITELISTED = "SpenderWhitelist: Spender is not whitelisted";

    error RuleSpenderWhitelist_InvalidTransferFrom(
        address ruleEngine, address spender, address from, address to, uint256 value, uint8 restrictionCode
    );
}
