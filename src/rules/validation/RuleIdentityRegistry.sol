// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {AccessControl} from "OZ/access/AccessControl.sol";
import {AccessControlModuleStandalone} from "../../modules/AccessControlModuleStandalone.sol";
import {RuleNFTAdapter} from "./abstract/RuleNFTAdapter.sol";
import {RuleIdentityRegistryInvariantStorage} from "./abstract/RuleIdentityRegistryInvariantStorage.sol";
import {RuleValidateTransfer} from "./abstract/RuleValidateTransfer.sol";
import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {IERC3643IComplianceContract} from "CMTAT/interfaces/tokenization/IERC3643Partial.sol";
import {IRuleEngine} from "CMTAT/interfaces/engine/IRuleEngine.sol";
import {IIdentityRegistryVerified} from "../interfaces/IIdentityRegistry.sol";

/**
 * @title RuleIdentityRegistry
 * @notice Checks the ERC-3643 Identity Registry for transfer participants when configured.
 * @dev Burns (to == address(0)) are allowed even if the sender is not verified.
 */
contract RuleIdentityRegistry is
    AccessControlModuleStandalone,
    RuleNFTAdapter,
    RuleIdentityRegistryInvariantStorage
{
    IIdentityRegistryVerified public identityRegistry;

    constructor(address admin, address identityRegistry_) AccessControlModuleStandalone(admin) {
        if (identityRegistry_ != address(0)) {
            identityRegistry = IIdentityRegistryVerified(identityRegistry_);
        }
    }

    function setIdentityRegistry(address newRegistry) public onlyIdentityRegistryManager {
        if (newRegistry == address(0)) {
            revert RuleIdentityRegistry_RegistryAddressZeroNotAllowed();
        }
        identityRegistry = IIdentityRegistryVerified(newRegistry);
        emit IdentityRegistryUpdated(newRegistry);
    }

    function clearIdentityRegistry() public onlyIdentityRegistryManager {
        identityRegistry = IIdentityRegistryVerified(address(0));
        emit IdentityRegistryUpdated(address(0));
    }

    function _detectTransferRestriction(address from, address to, uint256 /* value */)
        internal
        view
        override
        returns (uint8)
    {
        if (address(identityRegistry) == address(0)) {
            return uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
        }
        // Allow burns from non-verified addresses to avoid blocking burn flows.
        if (to == address(0)) {
            return uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
        }

        if (from != address(0) && !identityRegistry.isVerified(from)) {
            return CODE_ADDRESS_FROM_NOT_VERIFIED;
        }
        if (to != address(0) && !identityRegistry.isVerified(to)) {
            return CODE_ADDRESS_TO_NOT_VERIFIED;
        }
        return uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
    }

    function _detectTransferRestrictionFrom(address spender, address from, address to, uint256 value)
        internal
        view
        override
        returns (uint8)
    {
        if (address(identityRegistry) == address(0)) {
            return uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
        }
        // Allow burns from non-verified addresses to avoid blocking burn flows.
        if (to == address(0)) {
            return uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
        }
        if (spender != address(0) && !identityRegistry.isVerified(spender)) {
            return CODE_ADDRESS_SPENDER_NOT_VERIFIED;
        }
        return _detectTransferRestriction(from, to, value);
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
        _transferred(from, to, value);
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
        _transferredFrom(spender, from, to, value);
    }

    function _transferred(address from, address to, uint256 value) internal view override {
        uint8 code = _detectTransferRestriction(from, to, value);
        require(
            code == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK),
            RuleIdentityRegistry_InvalidTransfer(address(this), from, to, value, code)
        );
    }

    function _transferredFrom(address spender, address from, address to, uint256 value) internal view override {
        uint8 code = _detectTransferRestrictionFrom(spender, from, to, value);
        require(
            code == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK),
            RuleIdentityRegistry_InvalidTransferFrom(address(this), spender, from, to, value, code)
        );
    }

    // ERC-7943 tokenId overloads are provided by {RuleNFTAdapter}.

    function canReturnTransferRestrictionCode(uint8 restrictionCode) external pure override returns (bool) {
        return restrictionCode == CODE_ADDRESS_FROM_NOT_VERIFIED || restrictionCode == CODE_ADDRESS_TO_NOT_VERIFIED
            || restrictionCode == CODE_ADDRESS_SPENDER_NOT_VERIFIED;
    }

    function messageForTransferRestriction(uint8 restrictionCode)
        public
        pure
        override(IERC1404)
        returns (string memory)
    {
        if (restrictionCode == CODE_ADDRESS_FROM_NOT_VERIFIED) {
            return TEXT_ADDRESS_FROM_NOT_VERIFIED;
        } else if (restrictionCode == CODE_ADDRESS_TO_NOT_VERIFIED) {
            return TEXT_ADDRESS_TO_NOT_VERIFIED;
        } else if (restrictionCode == CODE_ADDRESS_SPENDER_NOT_VERIFIED) {
            return TEXT_ADDRESS_SPENDER_NOT_VERIFIED;
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

    modifier onlyIdentityRegistryManager() {
        _authorizeIdentityRegistryManager();
        _;
    }

    function _authorizeIdentityRegistryManager() internal virtual {
        _checkRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }
}
