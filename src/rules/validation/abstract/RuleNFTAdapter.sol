// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {
    IERC7943NonFungibleCompliance,
    IERC7943NonFungibleComplianceExtend
} from "../../interfaces/IERC7943NonFungibleCompliance.sol";
import {RuleValidateTransfer} from "./RuleValidateTransfer.sol";

/**
 * @title Rule NFT Adapter
 * @notice Provides ERC-7943 overloads for rules that already implement core transfer checks.
 * @dev Delegates tokenId overloads to RuleValidateTransfer's internal hooks.
 */
abstract contract RuleNFTAdapter is RuleValidateTransfer, IERC7943NonFungibleComplianceExtend {
    /**
     * @notice Internal hook for post-transfer validation or state updates.
     */
    function _transferred(address from, address to, uint256 value) internal virtual;

    /**
     * @notice Internal hook for post-transfer validation or state updates (spender-aware).
     */
    function _transferredFrom(address spender, address from, address to, uint256 value) internal virtual;
    /**
     * @inheritdoc IERC7943NonFungibleComplianceExtend
     */
    function detectTransferRestriction(address from, address to, uint256 /* tokenId */, uint256 value)
        public
        view
        virtual
        override(IERC7943NonFungibleComplianceExtend)
        returns (uint8)
    {
        return _detectTransferRestriction(from, to, value);
    }

    /**
     * @inheritdoc IERC7943NonFungibleComplianceExtend
     */
    function detectTransferRestrictionFrom(
        address spender,
        address from,
        address to,
        uint256 /* tokenId */,
        uint256 value
    ) public view virtual override(IERC7943NonFungibleComplianceExtend) returns (uint8) {
        return _detectTransferRestrictionFrom(spender, from, to, value);
    }

    /**
     * @inheritdoc IERC7943NonFungibleCompliance
     */
    function canTransfer(address from, address to, uint256 /* tokenId */, uint256 amount)
        public
        view
        override(IERC7943NonFungibleCompliance)
        returns (bool)
    {
        return _detectTransferRestriction(from, to, amount) == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
    }

    /**
     * @inheritdoc IERC7943NonFungibleComplianceExtend
     */
    function canTransferFrom(address spender, address from, address to, uint256 /* tokenId */, uint256 value)
        public
        view
        virtual
        override(IERC7943NonFungibleComplianceExtend)
        returns (bool)
    {
        return _detectTransferRestrictionFrom(spender, from, to, value)
            == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
    }

    /**
     * @inheritdoc IERC7943NonFungibleComplianceExtend
     */
    function transferred(address from, address to, uint256 /* tokenId */, uint256 value)
        public
        virtual
        override(IERC7943NonFungibleComplianceExtend)
    {
        _transferred(from, to, value);
    }

    /**
     * @inheritdoc IERC7943NonFungibleComplianceExtend
     */
    function transferred(address spender, address from, address to, uint256 /* tokenId */, uint256 value)
        public
        virtual
        override(IERC7943NonFungibleComplianceExtend)
    {
        _transferredFrom(spender, from, to, value);
    }
}
