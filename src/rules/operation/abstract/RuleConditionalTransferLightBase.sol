// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {IRuleEngine} from "CMTAT/interfaces/engine/IRuleEngine.sol";
import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {IERC3643ComplianceRead, IERC3643IComplianceContract} from "CMTAT/interfaces/tokenization/IERC3643Partial.sol";
import {IERC7551Compliance} from "CMTAT/interfaces/tokenization/draft-IERC7551.sol";
import {IRule} from "RuleEngine/interfaces/IRule.sol";
import {ITransferContext} from "../../interfaces/ITransferContext.sol";
import {IERC20} from "OZ/token/ERC20/IERC20.sol";
import {
    RuleConditionalTransferLightInvariantStorage
} from "./RuleConditionalTransferLightInvariantStorage.sol";

/**
 * @title RuleConditionalTransferLightBase
 * @dev Requires operator approval for each transfer. Same transfer (from, to, value)
 *      can be approved multiple times to allow repeated transfers.
 */
abstract contract RuleConditionalTransferLightBase is RuleConditionalTransferLightInvariantStorage, IRule {
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

    /**
     * @notice Approves and performs a transferFrom using this rule as spender.
     * @dev Requires `from` to have approved this contract on the token.
     * @dev This function is only safe for tokens that call back `transferred()` during transfer.
     * @dev CEI is intentionally inverted so the approval exists for the callback.
     */
    function approveAndTransferIfAllowed(address token, address from, address to, uint256 value)
        public
        onlyTransferApprover
        returns (bool)
    {
        require(token != address(0), RuleConditionalTransferLight_TokenAddressZeroNotAllowed());

        approveTransfer(from, to, value);

        uint256 allowed = IERC20(token).allowance(from, address(this));
        require(
            allowed >= value,
            RuleConditionalTransferLight_InsufficientAllowance(token, from, allowed, value)
        );

        bool success = IERC20(token).transferFrom(from, to, value);
        require(success, RuleConditionalTransferLight_TransferFailed());
        return true;
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
        _transferred(from, to, value);
    }

    function transferred(address /* spender */, address from, address to, uint256 value)
        public
        override(IRuleEngine)
        onlyTransferExecutor
    {
        _transferred(from, to, value);
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

    function transferred(ITransferContext.FungibleTransferContext calldata ctx) external onlyTransferExecutor {
        _transferredFromContext(ctx);
    }

    function _transferredFromContext(ITransferContext.FungibleTransferContext calldata ctx) internal virtual {
        _transferred(ctx.from, ctx.to, ctx.value);
    }

    function _transferred(address from, address to, uint256 value) internal virtual {
        bytes32 transferHash = _transferHash(from, to, value);
        uint256 count = approvalCounts[transferHash];

        require(count != 0, TransferNotApproved());

        approvalCounts[transferHash] = count - 1;
        emit TransferExecuted(from, to, value, approvalCounts[transferHash]);
    }

    function _transferHash(address from, address to, uint256 value) internal pure virtual returns (bytes32 hash) {
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
