// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {RuleSharedInvariantStorage} from "../../validation/abstract/invariant/RuleSharedInvariantStorage.sol";

abstract contract RuleConditionalTransferLightInvariantStorage is RuleSharedInvariantStorage {
    /* ============ Role ============ */
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");

    /* ============ State variables ============ */
    string constant TEXT_TRANSFER_REQUEST_NOT_APPROVED = "ConditionalTransferLight: The request is not approved";
    // It is very important that each rule uses an unique code
    uint8 public constant CODE_TRANSFER_REQUEST_NOT_APPROVED = 46;

    /* ============ Custom error ============ */
    error RuleConditionalTransferLight_AdminAddressZeroNotAllowed();
    error RuleConditionalTransferLight_TransferExecutorUnauthorized(address account);
    error RuleConditionalTransferLight_TokenAddressZeroNotAllowed();
    error RuleConditionalTransferLight_InsufficientAllowance(
        address token, address owner, uint256 allowance, uint256 required
    );
    error RuleConditionalTransferLight_TransferFailed();
    error TransferNotApproved();
    error TransferApprovalNotFound();

    /* ============ Events ============ */
    event TransferApproved(address indexed from, address indexed to, uint256 value, uint256 count);
    event TransferExecuted(address indexed from, address indexed to, uint256 value, uint256 remaining);
    event TransferApprovalCancelled(address indexed from, address indexed to, uint256 value, uint256 remaining);
}
