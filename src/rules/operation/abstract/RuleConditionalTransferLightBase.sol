// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {IRuleEngine} from "CMTAT/interfaces/engine/IRuleEngine.sol";
import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {IERC3643ComplianceRead, IERC3643IComplianceContract} from "CMTAT/interfaces/tokenization/IERC3643Partial.sol";
import {IERC7551Compliance} from "CMTAT/interfaces/tokenization/draft-IERC7551.sol";
import {IRule} from "RuleEngine/interfaces/IRule.sol";
import {ITransferContext} from "../../interfaces/ITransferContext.sol";
import {
    RuleConditionalTransferLightInvariantStorage
} from "./RuleConditionalTransferLightInvariantStorage.sol";

/**
 * @title RuleConditionalTransferLightBase
 * @dev Requires operator approval for each transfer. Same transfer (from, to, value)
 *      can be approved multiple times to allow repeated transfers.
 */
abstract contract RuleConditionalTransferLightBase is RuleConditionalTransferLightInvariantStorage, IRule, ITransferContext {
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

    function transferred(address from, address to, uint256 value)
        public
        override(IERC3643IComplianceContract)
        onlyTransferExecutor
    {
        bytes32 transferHash = _transferHash(from, to, value);
        uint256 count = approvalCounts[transferHash];

        require(count != 0, TransferNotApproved());

        approvalCounts[transferHash] = count - 1;
        emit TransferExecuted(from, to, value, approvalCounts[transferHash]);
    }

    function transferred(address /* spender */, address from, address to, uint256 value)
        public
        override(IRuleEngine)
        onlyTransferExecutor
    {
        transferred(from, to, value);
    }

    function detectTransferRestriction(address from, address to, uint256 value)
        public
        view
        override(IERC1404)
        returns (uint8)
    {
        bytes32 transferHash = _transferHash(from, to, value);
        if (approvalCounts[transferHash] == 0) {
            return CODE_TRANSFER_REQUEST_NOT_APPROVED;
        }
        return uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
    }

    function detectTransferRestrictionFrom(address /* spender */, address from, address to, uint256 value)
        public
        view
        override(IERC1404Extend)
        returns (uint8)
    {
        return detectTransferRestriction(from, to, value);
    }

    function canTransfer(address from, address to, uint256 value)
        public
        view
        override(IERC3643ComplianceRead)
        returns (bool)
    {
        return detectTransferRestriction(from, to, value) == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
    }

    function canTransferFrom(address spender, address from, address to, uint256 value)
        public
        view
        override(IERC7551Compliance)
        returns (bool)
    {
        return detectTransferRestrictionFrom(spender, from, to, value)
            == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
    }

    function canReturnTransferRestrictionCode(uint8 restrictionCode) external pure override(IRule) returns (bool) {
        return restrictionCode == CODE_TRANSFER_REQUEST_NOT_APPROVED;
    }

    function messageForTransferRestriction(uint8 restrictionCode)
        external
        pure
        override(IERC1404)
        returns (string memory)
    {
        if (restrictionCode == CODE_TRANSFER_REQUEST_NOT_APPROVED) {
            return TEXT_TRANSFER_REQUEST_NOT_APPROVED;
        }
        return TEXT_CODE_NOT_FOUND;
    }

    function transferred(ITransferContext.TransferContext calldata ctx) external override(ITransferContext) {
        if (ctx.sender != address(0)) {
            transferred(ctx.sender, ctx.from, ctx.to, ctx.value);
        } else {
            transferred(ctx.from, ctx.to, ctx.value);
        }
    }

    function transferred(ITransferContext.TransferContextFungible calldata ctx)
        external
        override(ITransferContext)
    {
        if (ctx.sender != address(0)) {
            transferred(ctx.sender, ctx.from, ctx.to, ctx.value);
        } else {
            transferred(ctx.from, ctx.to, ctx.value);
        }
    }

    function _transferHash(address from, address to, uint256 value) internal pure returns (bytes32 hash) {
        return keccak256(abi.encodePacked(from, to, value));
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
