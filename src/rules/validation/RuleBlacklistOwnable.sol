// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Ownable} from "OZ/access/Ownable.sol";
import {Ownable2Step} from "OZ/access/Ownable2Step.sol";
import {Context} from "OZ/utils/Context.sol";
import {RuleBlacklistBase} from "./abstract/RuleBlacklistBase.sol";
import {RuleAddressSet} from "./abstract/RuleAddressSet/RuleAddressSet.sol";

/**
 * @title RuleBlacklistOwnable
 * @notice Ownable variant of RuleBlacklist with owner-based authorization hooks.
 */
contract RuleBlacklistOwnable is RuleBlacklistBase, Ownable2Step {
    constructor(address owner, address forwarderIrrevocable)
        RuleBlacklistBase(forwarderIrrevocable)
        Ownable(owner)
    {}

    function _authorizeAddressListAdd() internal view override {
        _checkOwner();
    }

    function _authorizeAddressListRemove() internal view override {
        _checkOwner();
    }

    function _msgSender() internal view override(Context, RuleAddressSet) returns (address sender) {
        return super._msgSender();
    }

    function _msgData() internal view override(Context, RuleAddressSet) returns (bytes calldata) {
        return super._msgData();
    }

    function _contextSuffixLength() internal view override(Context, RuleAddressSet) returns (uint256) {
        return super._contextSuffixLength();
    }
}
