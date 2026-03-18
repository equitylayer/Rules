// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {ITransferContext} from "../../interfaces/ITransferContext.sol";
import {RuleConditionalTransferLightInvariantStorage} from "./RuleConditionalTransferLightInvariantStorage.sol";

/**
 * @title RuleConditionalTransferLightApprovalBase
 * @dev Pure approval state machine: stores and consumes per-transfer approvals.
 *      No knowledge of token binding or compliance interfaces.
 */
abstract contract RuleConditionalTransferLightApprovalBase is RuleConditionalTransferLightInvariantStorage {
    // Mapping from transfer hash to approval count
    mapping(bytes32 => uint256) public approvalCounts;

    function approveTransfer(address from, address to, uint256 value) public onlyTransferApprover {
        bytes32 transferHash = _transferHash(from, to, value);
        approvalCounts[transferHash] += 1;
        emit TransferApproved(from, to, value, approvalCounts[transferHash]);
    }

    function cancelTransferApproval(address from, address to, uint256 value) public onlyTransferApprover {
        bytes32 transferHash = _transferHash(from, to, value);
        uint256 count = approvalCounts[transferHash];
        require(count != 0, TransferApprovalNotFound());
        approvalCounts[transferHash] = count - 1;
        emit TransferApprovalCancelled(from, to, value, approvalCounts[transferHash]);
    }

    function approvedCount(address from, address to, uint256 value) public view returns (uint256) {
        bytes32 transferHash = _transferHash(from, to, value);
        return approvalCounts[transferHash];
    }

    function transferred(ITransferContext.FungibleTransferContext calldata ctx) external onlyTransferExecutor {
        _transferredFromContext(ctx);
    }

    function _transferredFromContext(ITransferContext.FungibleTransferContext calldata ctx) internal virtual {
        _transferred(ctx.from, ctx.to, ctx.value);
    }

    function _transferred(address from, address to, uint256 value) internal virtual {
        if (from == address(0) || to == address(0)) {
            return;
        }
        bytes32 transferHash = _transferHash(from, to, value);
        uint256 count = approvalCounts[transferHash];

        require(count != 0, TransferNotApproved());

        approvalCounts[transferHash] = count - 1;
        emit TransferExecuted(from, to, value, approvalCounts[transferHash]);
    }

    function _transferHash(address from, address to, uint256 value) internal pure virtual returns (bytes32 hash) {
        // Linter suggestion (`asm-keccak256`): hash packed values in assembly to avoid abi.encodePacked overhead.
        assembly ("memory-safe") {
            let ptr := mload(0x40)
            mstore(ptr, shl(96, from))
            mstore(add(ptr, 0x20), shl(96, to))
            mstore(add(ptr, 0x40), value)
            hash := keccak256(ptr, 0x60)
        }
    }

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    modifier onlyTransferApprover() {
        _authorizeTransferApproval();
        _;
    }

    modifier onlyTransferExecutor() {
        _authorizeTransferExecution();
        _;
    }

    function _authorizeTransferApproval() internal view virtual;

    function _authorizeTransferExecution() internal view virtual;
}
