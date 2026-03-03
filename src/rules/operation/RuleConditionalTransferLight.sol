// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {AccessControl} from "OZ/access/AccessControl.sol";
import {IERC165} from "OZ/utils/introspection/IERC165.sol";
import {IRuleEngine} from "CMTAT/interfaces/engine/IRuleEngine.sol";
import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {IERC3643ComplianceRead, IERC3643IComplianceContract} from "CMTAT/interfaces/tokenization/IERC3643Partial.sol";
import {IERC7551Compliance} from "CMTAT/interfaces/tokenization/draft-IERC7551.sol";
import {IRule} from "RuleEngine/interfaces/IRule.sol";
import {RuleInterfaceId} from "RuleEngine/modules/library/RuleInterfaceId.sol";

import {
    RuleConditionalTransferLightInvariantStorage
} from "./abstract/RuleConditionalTransferLightInvariantStorage.sol";

/**
 * @title ConditionalTransferLight
 * @dev Requires operator approval for each transfer. Same transfer (from, to, value)
 *      can be approved multiple times to allow repeated transfers.
 */
contract RuleConditionalTransferLight is
    AccessControl,
    RuleConditionalTransferLightInvariantStorage,
    IRule
{
    // Mapping from transfer hash to approval count
    mapping(bytes32 => uint256) public approvalCounts;

    constructor(address admin, IRuleEngine ruleEngineContract) {
        if (admin == address(0)) {
            revert RuleConditionalTransferLight_AdminAddressZeroNotAllowed();
        }

        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(OPERATOR_ROLE, admin);
        if (address(ruleEngineContract) != address(0)) {
            _grantRole(RULE_ENGINE_CONTRACT_ROLE, address(ruleEngineContract));
        }
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControl, IERC165)
        returns (bool)
    {
        return interfaceId == RuleInterfaceId.IRULE_INTERFACE_ID || interfaceId == type(IRule).interfaceId
            || super.supportsInterface(interfaceId);
    }

    /**
     * @notice Approve a specific transfer. Can be approved multiple times.
     */
    function approveTransfer(address from, address to, uint256 value) public onlyTransferApprover {
        bytes32 transferHash = _transferHash(from, to, value);
        approvalCounts[transferHash] += 1;
        emit TransferApproved(from, to, value, approvalCounts[transferHash]);
    }

    /**
     * @notice Cancel a previously approved transfer.
     */
    function cancelTransferApproval(address from, address to, uint256 value) public onlyTransferApprover {
        bytes32 transferHash = _transferHash(from, to, value);
        uint256 count = approvalCounts[transferHash];
        if (count == 0) {
            revert TransferApprovalNotFound();
        }
        approvalCounts[transferHash] = count - 1;
        emit TransferApprovalCancelled(from, to, value, approvalCounts[transferHash]);
    }

    /**
     * @notice Returns number of times a transfer is approved.
     */
    function approvedCount(address from, address to, uint256 value) public view returns (uint256) {
        bytes32 transferHash = _transferHash(from, to, value);
        return approvalCounts[transferHash];
    }

    /**
     * @notice Called when a transfer occurs. Decrements approval count if allowed.
     * @dev `spender` is part of the interface but unused.
     */
    function transferred(address from, address to, uint256 value)
        public
        override(IERC3643IComplianceContract)
        onlyTransferExecutor
    {
        bytes32 transferHash = _transferHash(from, to, value);
        uint256 count = approvalCounts[transferHash];

        if (count == 0) {
            revert TransferNotApproved();
        }

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

    /**
     * @notice Check if the transfer is valid.
     * @return Restriction code or TRANSFER_OK.
     */
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

    function _transferHash(address from, address to, uint256 value) internal pure returns (bytes32 hash) {
        return keccak256(abi.encodePacked(from, to, value));
    }

    function detectTransferRestrictionFrom(address /* spender */, address from, address to, uint256 value)
        public
        view
        override(IERC1404Extend)
        returns (uint8)
    {
        return detectTransferRestriction(from, to, value);
    }

    function canReturnTransferRestrictionCode(uint8 restrictionCode) external pure override returns (bool) {
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

    function _authorizeTransferApproval() internal virtual {
        _checkRole(OPERATOR_ROLE, _msgSender());
    }

    function _authorizeTransferExecution() internal virtual {
        _checkRole(RULE_ENGINE_CONTRACT_ROLE, _msgSender());
    }
}
