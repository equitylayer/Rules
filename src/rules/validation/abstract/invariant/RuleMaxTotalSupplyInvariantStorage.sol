// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {RuleSharedInvariantStorage} from "./RuleSharedInvariantStorage.sol";

abstract contract RuleMaxTotalSupplyInvariantStorage is RuleSharedInvariantStorage {
    string constant TEXT_MAX_TOTAL_SUPPLY_EXCEEDED = "Max total supply exceeded";

    // It is very important that each rule uses an unique code
    uint8 public constant CODE_MAX_TOTAL_SUPPLY_EXCEEDED = 50;

    event MaxTotalSupplyUpdated(uint256 newMaxTotalSupply);
    event TokenContractUpdated(address indexed newTokenContract);

    error RuleMaxTotalSupply_InvalidTransfer(address rule, address from, address to, uint256 value, uint8 code);
    error RuleMaxTotalSupply_InvalidTransferFrom(
        address rule, address spender, address from, address to, uint256 value, uint8 code
    );
    error RuleMaxTotalSupply_TokenAddressZeroNotAllowed();
}
