// SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== OpenZeppelin === */
import {Ownable} from "OZ/access/Ownable.sol";
import {Ownable2Step} from "OZ/access/Ownable2Step.sol";
import {Context} from "OZ/utils/Context.sol";
/* ==== Abstract contracts === */
import {RuleWhitelistWrapperBase} from "./abstract/RuleWhitelistWrapperBase.sol";

/**
 * @title Wrapper to call several different whitelist rules (Ownable2Step)
 */
contract RuleWhitelistWrapperOwnable2Step is RuleWhitelistWrapperBase, Ownable2Step {
    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/
    /**
     * @param owner Address of the contract owner
     * @param forwarderIrrevocable Address of the forwarder, required for the gasless support
     */
    constructor(address owner, address forwarderIrrevocable, bool checkSpender_)
        RuleWhitelistWrapperBase(forwarderIrrevocable, checkSpender_)
        Ownable(owner)
    {}

    function _authorizeCheckSpenderManager() internal view override {
        _checkOwner();
    }

    /**
     * @dev Restrict rules management to the owner.
     */
    function _onlyRulesManager() internal view override {
        _checkOwner();
    }

    /*//////////////////////////////////////////////////////////////
                           ERC-2771
    //////////////////////////////////////////////////////////////*/

    function _msgSender() internal view override(RuleWhitelistWrapperBase, Context) returns (address sender) {
        return RuleWhitelistWrapperBase._msgSender();
    }

    function _msgData() internal view override(RuleWhitelistWrapperBase, Context) returns (bytes calldata) {
        return RuleWhitelistWrapperBase._msgData();
    }

    function _contextSuffixLength() internal view override(RuleWhitelistWrapperBase, Context) returns (uint256) {
        return RuleWhitelistWrapperBase._contextSuffixLength();
    }

}
