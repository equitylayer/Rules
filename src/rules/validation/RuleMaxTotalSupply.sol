// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {AccessControl} from "OZ/access/AccessControl.sol";
import {AccessControlModuleStandalone} from "../../modules/AccessControlModuleStandalone.sol";
import {RuleValidateTransfer} from "./abstract/RuleValidateTransfer.sol";
import {RuleMaxTotalSupplyInvariantStorage} from "./abstract/RuleMaxTotalSupplyInvariantStorage.sol";
import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {
    IERC7943NonFungibleComplianceExtend
} from "../interfaces/IERC7943NonFungibleCompliance.sol";
import {IERC3643IComplianceContract} from "CMTAT/interfaces/tokenization/IERC3643Partial.sol";
import {IRuleEngine} from "CMTAT/interfaces/engine/IRuleEngine.sol";

interface ITotalSupply {
    function totalSupply() external view returns (uint256);
}

/**
 * @title RuleMaxTotalSupply
 * @notice Restricts minting so that total supply never exceeds a maximum value.
 */
contract RuleMaxTotalSupply is AccessControlModuleStandalone, RuleValidateTransfer, RuleMaxTotalSupplyInvariantStorage {
    ITotalSupply public tokenContract;
    uint256 public maxTotalSupply;

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
        tokenContract = ITotalSupply(newTokenContract);
        emit TokenContractUpdated(newTokenContract);
    }

    function detectTransferRestriction(address from, address, uint256 value)
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

    function detectTransferRestriction(address from, address to, uint256, uint256 value)
        public
        view
        override(IERC7943NonFungibleComplianceExtend)
        returns (uint8)
    {
        return detectTransferRestriction(from, to, value);
    }

    function detectTransferRestrictionFrom(address, address from, address to, uint256 value)
        public
        view
        override(IERC1404Extend)
        returns (uint8)
    {
        return detectTransferRestriction(from, to, value);
    }

    function detectTransferRestrictionFrom(
        address spender,
        address from,
        address to,
        uint256,
        uint256 value
    ) public view override(IERC7943NonFungibleComplianceExtend) returns (uint8) {
        return detectTransferRestrictionFrom(spender, from, to, value);
    }

    function transferred(address from, address to, uint256 value)
        public
        view
        override(IERC3643IComplianceContract)
    {
        uint8 code = this.detectTransferRestriction(from, to, value);
        require(
            code == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK),
            RuleMaxTotalSupply_InvalidTransfer(address(this), from, to, value, code)
        );
    }

    function transferred(address spender, address from, address to, uint256 value)
        public
        view
        override(IRuleEngine)
    {
        uint8 code = this.detectTransferRestrictionFrom(spender, from, to, value);
        require(
            code == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK),
            RuleMaxTotalSupply_InvalidTransferFrom(address(this), spender, from, to, value, code)
        );
    }

    function transferred(address from, address to, uint256, uint256 value)
        public
        view
        override(IERC7943NonFungibleComplianceExtend)
    {
        transferred(from, to, value);
    }

    function transferred(address spender, address from, address to, uint256, uint256 value)
        public
        view
        override(IERC7943NonFungibleComplianceExtend)
    {
        transferred(spender, from, to, value);
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
