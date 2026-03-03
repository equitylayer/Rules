// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {IERC3643IComplianceContract} from "CMTAT/interfaces/tokenization/IERC3643Partial.sol";
import {IRuleEngine} from "CMTAT/interfaces/engine/IRuleEngine.sol";
import {IERC7943NonFungibleComplianceExtend} from "../../interfaces/IERC7943NonFungibleCompliance.sol";

/**
 * @title Rule NFT Adapter
 * @notice ERC-7943 tokenId overload adapter for rules that already implement value-based logic.
 * @dev Delegates tokenId overloads to the non-tokenId counterparts.
 */
abstract contract RuleNFTAdapter is IERC7943NonFungibleComplianceExtend {
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
        return IERC1404(address(this)).detectTransferRestriction(from, to, value);
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
        return IERC1404Extend(address(this)).detectTransferRestrictionFrom(spender, from, to, value);
    }

    /**
     * @inheritdoc IERC7943NonFungibleComplianceExtend
     */
    function transferred(address from, address to, uint256 /* tokenId */, uint256 value)
        public
        virtual
        override(IERC7943NonFungibleComplianceExtend)
    {
        IERC3643IComplianceContract(address(this)).transferred(from, to, value);
    }

    /**
     * @inheritdoc IERC7943NonFungibleComplianceExtend
     */
    function transferred(address spender, address from, address to, uint256 /* tokenId */, uint256 value)
        public
        virtual
        override(IERC7943NonFungibleComplianceExtend)
    {
        IRuleEngine(address(this)).transferred(spender, from, to, value);
    }
}
