// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {AccessControlEnumerable} from "OZ/access/extensions/AccessControlEnumerable.sol";
import {Context} from "OZ/utils/Context.sol";
import {AccessControlModuleStandalone} from "../../../modules/AccessControlModuleStandalone.sol";
import {RuleSpenderWhitelistBase} from "../abstract/base/RuleSpenderWhitelistBase.sol";
import {RuleAddressSet} from "../abstract/RuleAddressSet/RuleAddressSet.sol";
import {RuleTransferValidation} from "../abstract/core/RuleTransferValidation.sol";

/**
 * @title RuleSpenderWhitelist
 * @notice AccessControlEnumerable deployment variant of spender whitelist rule.
 */
contract RuleSpenderWhitelist is RuleSpenderWhitelistBase, AccessControlModuleStandalone {
    constructor(address admin, address forwarderIrrevocable)
        RuleSpenderWhitelistBase(forwarderIrrevocable)
        AccessControlModuleStandalone(admin)
    {}

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControlEnumerable, RuleTransferValidation)
        returns (bool)
    {
        return AccessControlEnumerable.supportsInterface(interfaceId)
            || RuleTransferValidation.supportsInterface(interfaceId);
    }

    function _authorizeAddressListAdd() internal view virtual override onlyRole(ADDRESS_LIST_ADD_ROLE) {}

    function _authorizeAddressListRemove() internal view virtual override onlyRole(ADDRESS_LIST_REMOVE_ROLE) {}

    function _msgSender() internal view virtual override(Context, RuleAddressSet) returns (address sender) {
        return super._msgSender();
    }

    function _msgData() internal view virtual override(Context, RuleAddressSet) returns (bytes calldata) {
        return super._msgData();
    }

    function _contextSuffixLength() internal view virtual override(Context, RuleAddressSet) returns (uint256) {
        return super._contextSuffixLength();
    }
}
