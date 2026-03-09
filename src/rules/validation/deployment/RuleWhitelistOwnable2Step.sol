// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Ownable} from "OZ/access/Ownable.sol";
import {Ownable2Step} from "OZ/access/Ownable2Step.sol";
import {Context} from "OZ/utils/Context.sol";
import {RuleWhitelistBase} from "../abstract/base/RuleWhitelistBase.sol";
import {RuleAddressSet} from "../abstract/RuleAddressSet/RuleAddressSet.sol";

/**
 * @title RuleWhitelistOwnable2Step
 * @notice Ownable2Step variant of RuleWhitelist with owner-based authorization hooks.
 */
contract RuleWhitelistOwnable2Step is RuleWhitelistBase, Ownable2Step {
    constructor(address owner, address forwarderIrrevocable, bool checkSpender_)
        RuleWhitelistBase(forwarderIrrevocable, checkSpender_)
        Ownable(owner)
    {}

    function _authorizeAddressListAdd() internal view virtual override onlyOwner {}

    function _authorizeAddressListRemove() internal view virtual override onlyOwner {}

    function _authorizeCheckSpenderManager() internal view virtual override onlyOwner {}

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
