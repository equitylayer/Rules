// SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== OpenZeppelin === */
import {AccessControl} from "OZ/access/AccessControl.sol";
/* ==== Abstract contracts === */
import {MetaTxModuleStandalone, ERC2771Context} from "../../../modules/MetaTxModuleStandalone.sol";
import {Context} from "OZ/utils/Context.sol";
import {RuleWhitelistCommon} from "./RuleWhitelistCommon.sol";
import {RuleValidateTransfer} from "./RuleValidateTransfer.sol";
/* ==== RuleEngine === */
import {RulesManagementModule} from "RuleEngine/modules/RulesManagementModule.sol";
/* ==== CMTAT === */
import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
/* ==== Interfaces === */
import {IERC7943NonFungibleComplianceExtend} from "../../interfaces/IERC7943NonFungibleCompliance.sol";
import {IAddressList} from "../../interfaces/IAddressList.sol";

/**
 * @title Wrapper to call several different whitelist rules (base)
 * @dev Child rules must implement {IAddressList}.
 */
abstract contract RuleWhitelistWrapperBase is
    RulesManagementModule,
    MetaTxModuleStandalone,
    RuleWhitelistCommon
{
    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/
    /**
     * @param forwarderIrrevocable Address of the forwarder, required for the gasless support
     */
    constructor(address forwarderIrrevocable, bool checkSpender_)
        MetaTxModuleStandalone(forwarderIrrevocable)
    {
        checkSpender = checkSpender_;
    }

    /* ============  View Functions ============ */
    /**
     * @notice Go through all the whitelist rules to know if a restriction exists on the transfer
     * @param from the origin address
     * @param to the destination address
     * @return The restricion code or REJECTED_CODE_BASE.TRANSFER_OK
     *
     */
    function detectTransferRestriction(address from, address to, uint256 /* value */)
        public
        view
        virtual
        override(IERC1404)
        returns (uint8)
    {
        address[] memory targetAddress = new address[](2);
        targetAddress[0] = from;
        targetAddress[1] = to;

        bool[] memory result = _detectTransferRestriction(targetAddress);
        if (!result[0]) {
            return CODE_ADDRESS_FROM_NOT_WHITELISTED;
        } else if (!result[1]) {
            return CODE_ADDRESS_TO_NOT_WHITELISTED;
        } else {
            return uint8(REJECTED_CODE_BASE.TRANSFER_OK);
        }
    }

    function detectTransferRestriction(address from, address to, uint256 /* tokenId */, uint256 value)
        public
        view
        virtual
        override(IERC7943NonFungibleComplianceExtend)
        returns (uint8)
    {
        return detectTransferRestriction(from, to, value);
    }

    function detectTransferRestrictionFrom(address spender, address from, address to, uint256 value)
        public
        view
        virtual
        override(IERC1404Extend)
        returns (uint8)
    {
        if (!checkSpender) {
            return detectTransferRestriction(from, to, value);
        }

        address[] memory targetAddress = new address[](3);
        targetAddress[0] = from;
        targetAddress[1] = to;
        targetAddress[2] = spender;

        bool[] memory result = _detectTransferRestriction(targetAddress);

        if (!result[0]) {
            return CODE_ADDRESS_FROM_NOT_WHITELISTED;
        } else if (!result[1]) {
            return CODE_ADDRESS_TO_NOT_WHITELISTED;
        } else if (!result[2]) {
            return CODE_ADDRESS_SPENDER_NOT_WHITELISTED;
        } else {
            return uint8(REJECTED_CODE_BASE.TRANSFER_OK);
        }
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
        return detectTransferRestrictionFrom(spender, from, to, value);
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

    /* ============  Access control ============ */

    /**
     * @notice Sets whether the rule should enforce spender-based checks.
     * @dev
     *  - Restricted to holders of the manager role.
     *  - Updates the internal `checkSpender` flag.
     *  - Emits a {CheckSpenderUpdated} event.
     * @param value The new state of the `checkSpender` flag.
     */
    function setCheckSpender(bool value) public virtual onlyCheckSpenderManager {
        _setCheckSpender(value);
        emit CheckSpenderUpdated(value);
    }

    /*//////////////////////////////////////////////////////////////
                            INTERNAL/PRIVATE FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function _detectTransferRestriction(address[] memory targetAddress) internal view returns (bool[] memory) {
        uint256 rulesLength = rulesCount();
        bool[] memory result = new bool[](targetAddress.length);
        for (uint256 i = 0; i < rulesLength; ++i) {
            // Call the whitelist rules
            // Gas cost grows with the number of rules. Keep the wrapper list bounded.
            bool[] memory isListed = IAddressList(rule(i)).areAddressesListed(targetAddress);
            for (uint256 j = 0; j < targetAddress.length; ++j) {
                if (isListed[j]) {
                    result[j] = true;
                }
            }

            // Break early if all listed
            bool allListed = true;
            for (uint256 k = 0; k < result.length; ++k) {
                if (!result[k]) {
                    allListed = false;
                    break;
                }
            }
            if (allListed) {
                break;
            }
        }
        return result;
    }

    /**
     *  @dev Internal helper to update the `checkSpender` flag.
     */
    function _setCheckSpender(bool value) internal {
        checkSpender = value;
    }

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    modifier onlyCheckSpenderManager() {
        _authorizeCheckSpenderManager();
        _;
    }

    function _authorizeCheckSpenderManager() internal virtual;

    /*//////////////////////////////////////////////////////////////
                           ERC-2771
    //////////////////////////////////////////////////////////////*/

    /**
     * @dev This surcharge is not necessary if you do not use the MetaTxModule
     */
    function _msgSender() internal view virtual override(ERC2771Context, Context) returns (address sender) {
        return ERC2771Context._msgSender();
    }

    /**
     * @dev This surcharge is not necessary if you do not use the MetaTxModule
     */
    function _msgData() internal view virtual override(ERC2771Context, Context) returns (bytes calldata) {
        return ERC2771Context._msgData();
    }

    /**
     * @dev This surcharge is not necessary if you do not use the MetaTxModule
     */
    function _contextSuffixLength() internal view virtual override(ERC2771Context, Context) returns (uint256) {
        return ERC2771Context._contextSuffixLength();
    }
}
