// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {RuleAddressSet} from "./RuleAddressSet/RuleAddressSet.sol";
import {RuleWhitelistCommon} from "./RuleWhitelistCommon.sol";
import {RuleValidateTransfer} from "./RuleValidateTransfer.sol";
import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {IIdentityRegistryVerified} from "../../interfaces/IIdentityRegistry.sol";
import {
    IERC7943NonFungibleComplianceExtend
} from "../../interfaces/IERC7943NonFungibleCompliance.sol";

/**
 * @title RuleWhitelistBase
 * @notice Core whitelist logic without access-control policy.
 */
abstract contract RuleWhitelistBase is RuleAddressSet, RuleWhitelistCommon, IIdentityRegistryVerified {
    constructor(address forwarderIrrevocable, bool checkSpender_) RuleAddressSet(forwarderIrrevocable) {
        checkSpender = checkSpender_;
    }

    function detectTransferRestriction(address from, address to, uint256 /* value */ )
        public
        view
        virtual
        override(IERC1404)
        returns (uint8)
    {
        if (!isAddressListed(from)) {
            return CODE_ADDRESS_FROM_NOT_WHITELISTED;
        } else if (!isAddressListed(to)) {
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
        if (checkSpender && !isAddressListed(spender)) {
            return CODE_ADDRESS_SPENDER_NOT_WHITELISTED;
        }
        return detectTransferRestriction(from, to, value);
    }

    function detectTransferRestrictionFrom(
        address spender,
        address from,
        address to,
        uint256 /* tokenId */,
        uint256 value
    ) public view override(IERC7943NonFungibleComplianceExtend) returns (uint8) {
        return detectTransferRestrictionFrom(spender, from, to, value);
    }

    function isVerified(address targetAddress)
        public
        view
        virtual
        override(IIdentityRegistryVerified)
        returns (bool isListed)
    {
        isListed = _isAddressListed(targetAddress);
    }

    function setCheckSpender(bool value) public virtual onlyCheckSpenderManager {
        _setCheckSpender(value);
        emit CheckSpenderUpdated(value);
    }

    function _setCheckSpender(bool value) internal {
        checkSpender = value;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(RuleValidateTransfer) returns (bool) {
        return RuleValidateTransfer.supportsInterface(interfaceId);
    }

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    modifier onlyCheckSpenderManager() {
        _authorizeCheckSpenderManager();
        _;
    }

    function _authorizeCheckSpenderManager() internal view virtual;
}
