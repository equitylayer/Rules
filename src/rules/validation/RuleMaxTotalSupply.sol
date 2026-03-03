// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {AccessControl} from "OZ/access/AccessControl.sol";
import {AccessControlModuleStandalone} from "../../modules/AccessControlModuleStandalone.sol";
import {RuleValidateTransfer} from "./abstract/RuleValidateTransfer.sol";
import {RuleMaxTotalSupplyInvariantStorage} from "./abstract/RuleMaxTotalSupplyInvariantStorage.sol";
import {RuleNFTAdapter} from "./abstract/RuleNFTAdapter.sol";
import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {ITotalSupply} from "../interfaces/ITotalSupply.sol";
import {IERC3643IComplianceContract} from "CMTAT/interfaces/tokenization/IERC3643Partial.sol";
import {IRuleEngine} from "CMTAT/interfaces/engine/IRuleEngine.sol";

/**
 * @title RuleMaxTotalSupply
 * @notice Restricts minting so that total supply never exceeds a maximum value.
 */
contract RuleMaxTotalSupply is
    AccessControlModuleStandalone,
    RuleValidateTransfer,
    RuleNFTAdapter,
    RuleMaxTotalSupplyInvariantStorage
{
    /// @dev tokenContract is trusted to return a correct totalSupply.
    ITotalSupply public tokenContract;
    uint256 public maxTotalSupply;

    /**
     * @param admin Address that receives the default admin role.
     * @param tokenContract_ Token contract that exposes totalSupply (must be non-zero).
     * @param maxTotalSupply_ Initial maximum supply.
     */
    constructor(address admin, address tokenContract_, uint256 maxTotalSupply_) AccessControlModuleStandalone(admin) {
        if (tokenContract_ == address(0)) {
            revert RuleMaxTotalSupply_TokenAddressZeroNotAllowed();
        }
        tokenContract = ITotalSupply(tokenContract_);
        maxTotalSupply = maxTotalSupply_;
    }

    function setMaxTotalSupply(uint256 newMaxTotalSupply) public onlyMaxTotalSupplyManager {
        maxTotalSupply = newMaxTotalSupply;
        emit MaxTotalSupplyUpdated(newMaxTotalSupply);
    }

    function setTokenContract(address newTokenContract) public onlyMaxTotalSupplyManager {
        if (newTokenContract == address(0)) {
            revert RuleMaxTotalSupply_TokenAddressZeroNotAllowed();
        }
        // The admin is responsible for pointing to a compliant totalSupply implementation.
        tokenContract = ITotalSupply(newTokenContract);
        emit TokenContractUpdated(newTokenContract);
    }

    function detectTransferRestriction(address from, address /* to */, uint256 value)
        public
        view
        override(IERC1404)
        returns (uint8)
    {
        if (from == address(0)) {
            uint256 currentSupply = tokenContract.totalSupply();
            if (currentSupply + value > maxTotalSupply) {
                return CODE_MAX_TOTAL_SUPPLY_EXCEEDED;
            }
        }
        return uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
    }

    function detectTransferRestrictionFrom(address, address from, address to, uint256 value)
        public
        view
        override(IERC1404Extend)
        returns (uint8)
    {
        return detectTransferRestriction(from, to, value);
    }

    // ERC-7943 tokenId overloads are provided by {RuleNFTAdapter}.

    /**
     * @inheritdoc IERC3643IComplianceContract
     * @dev Validation only; does not modify state.
     */
    function transferred(address from, address to, uint256 value)
        public
        view
        override(IERC3643IComplianceContract)
    {
        // Required by ERC-3643 ICompliance, even for read-only rules.
        uint8 code = this.detectTransferRestriction(from, to, value);
        require(
            code == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK),
            RuleMaxTotalSupply_InvalidTransfer(address(this), from, to, value, code)
        );
    }

    /**
     * @inheritdoc IRuleEngine
     * @dev Validation only; does not modify state.
     */
    function transferred(address spender, address from, address to, uint256 value)
        public
        view
        override(IRuleEngine)
    {
        // Required by IRuleEngine, even for read-only rules.
        uint8 code = this.detectTransferRestrictionFrom(spender, from, to, value);
        require(
            code == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK),
            RuleMaxTotalSupply_InvalidTransferFrom(address(this), spender, from, to, value, code)
        );
    }

    // ERC-7943 tokenId overloads are provided by {RuleNFTAdapter}.

    function canReturnTransferRestrictionCode(uint8 restrictionCode) external pure override returns (bool) {
        return restrictionCode == CODE_MAX_TOTAL_SUPPLY_EXCEEDED;
    }

    function messageForTransferRestriction(uint8 restrictionCode)
        public
        pure
        override(IERC1404)
        returns (string memory)
    {
        if (restrictionCode == CODE_MAX_TOTAL_SUPPLY_EXCEEDED) {
            return TEXT_MAX_TOTAL_SUPPLY_EXCEEDED;
        }
        return TEXT_CODE_NOT_FOUND;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControl, RuleValidateTransfer)
        returns (bool)
    {
        return AccessControl.supportsInterface(interfaceId) || RuleValidateTransfer.supportsInterface(interfaceId);
    }

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    modifier onlyMaxTotalSupplyManager() {
        _authorizeMaxTotalSupplyManager();
        _;
    }

    function _authorizeMaxTotalSupplyManager() internal virtual {
        _checkRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }
}
