// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {RuleNFTAdapter} from "../core/RuleNFTAdapter.sol";
import {RuleMaxTotalSupplyInvariantStorage} from "../invariant/RuleMaxTotalSupplyInvariantStorage.sol";
import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {ITotalSupply} from "../../../interfaces/ITotalSupply.sol";
import {IERC3643IComplianceContract} from "CMTAT/interfaces/tokenization/IERC3643Partial.sol";
import {IRuleEngine} from "CMTAT/interfaces/engine/IRuleEngine.sol";

/**
 * @title RuleMaxTotalSupplyBase
 * @notice Restricts minting so that total supply never exceeds a maximum value.
 */
abstract contract RuleMaxTotalSupplyBase is RuleNFTAdapter, RuleMaxTotalSupplyInvariantStorage {
    /// @dev tokenContract is trusted to return a correct totalSupply.
    ITotalSupply public tokenContract;
    uint256 public maxTotalSupply;

    constructor(address tokenContract_, uint256 maxTotalSupply_) {
        require(tokenContract_ != address(0), RuleMaxTotalSupply_TokenAddressZeroNotAllowed());
        tokenContract = ITotalSupply(tokenContract_);
        maxTotalSupply = maxTotalSupply_;
    }

    function setMaxTotalSupply(uint256 newMaxTotalSupply) public onlyMaxTotalSupplyManager {
        maxTotalSupply = newMaxTotalSupply;
        emit MaxTotalSupplyUpdated(newMaxTotalSupply);
    }

    function setTokenContract(address newTokenContract) public onlyMaxTotalSupplyManager {
        require(newTokenContract != address(0), RuleMaxTotalSupply_TokenAddressZeroNotAllowed());
        tokenContract = ITotalSupply(newTokenContract);
        emit TokenContractUpdated(newTokenContract);
    }

    function _detectTransferRestriction(address from, address /* to */, uint256 value)
        internal
        view
        override
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

    function _detectTransferRestrictionFrom(address, address from, address to, uint256 value)
        internal
        view
        override
        returns (uint8)
    {
        return _detectTransferRestriction(from, to, value);
    }

    function transferred(address from, address to, uint256 value)
        public
        view
        override(IERC3643IComplianceContract)
    {
        _transferred(from, to, value);
    }

    function transferred(address spender, address from, address to, uint256 value)
        public
        view
        override(IRuleEngine)
    {
        _transferredFrom(spender, from, to, value);
    }

    function _transferred(address from, address to, uint256 value) internal view override {
        uint8 code = _detectTransferRestriction(from, to, value);
        require(
            code == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK),
            RuleMaxTotalSupply_InvalidTransfer(address(this), from, to, value, code)
        );
    }

    function _transferredFrom(address spender, address from, address to, uint256 value) internal view override {
        uint8 code = _detectTransferRestrictionFrom(spender, from, to, value);
        require(
            code == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK),
            RuleMaxTotalSupply_InvalidTransferFrom(address(this), spender, from, to, value, code)
        );
    }

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

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    modifier onlyMaxTotalSupplyManager() {
        _authorizeMaxTotalSupplyManager();
        _;
    }

    function _authorizeMaxTotalSupplyManager() internal view virtual;
}
