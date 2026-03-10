// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {RuleCommonInvariantStorage} from "./RuleCommonInvariantStorage.sol";

abstract contract RuleIdentityRegistryInvariantStorage is RuleCommonInvariantStorage {
    error RuleIdentityRegistry_InvalidTransfer(address rule, address from, address to, uint256 value, uint8 code);
    error RuleIdentityRegistry_InvalidTransferFrom(
        address rule, address spender, address from, address to, uint256 value, uint8 code
    );
    error RuleIdentityRegistry_RegistryAddressZeroNotAllowed();

    string constant TEXT_ADDRESS_FROM_NOT_VERIFIED = "The sender is not verified";
    string constant TEXT_ADDRESS_TO_NOT_VERIFIED = "The recipient is not verified";
    string constant TEXT_ADDRESS_SPENDER_NOT_VERIFIED = "The spender is not verified";

    // It is very important that each rule uses an unique code
    uint8 public constant CODE_ADDRESS_FROM_NOT_VERIFIED = 55;
    uint8 public constant CODE_ADDRESS_TO_NOT_VERIFIED = 56;
    uint8 public constant CODE_ADDRESS_SPENDER_NOT_VERIFIED = 57;

    event IdentityRegistryUpdated(address indexed newRegistry);
}
