// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

interface ITransferContext {
    /**
     * @notice Transfer context for unified rule entrypoints.
     * @dev Inspired by the TokenF contract: https://github.com/dl-tokenf/contracts
     * @param selector Function selector of the original call.
     * @param sender Operator/spender address for transferFrom or restricted operations.
     * @param from Token sender.
     * @param to Token recipient.
     * @param value Amount transferred (fungible).
     * @param tokenId Token id (non-fungible).
     */
    struct TransferContext {
        bytes4 selector;
        address sender;
        address from;
        address to;
        uint256 value;
        uint256 tokenId;
    }

    struct TransferContextFungible {
        bytes4 selector;
        address sender;
        address from;
        address to;
        uint256 value;
    }

    error TransferContext_InvalidSelector(bytes4 selector);

    function transferred(TransferContext calldata ctx) external;

    function transferred(TransferContextFungible calldata ctx) external;
}
