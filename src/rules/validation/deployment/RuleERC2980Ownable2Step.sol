// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Ownable} from "OZ/access/Ownable.sol";
import {Ownable2Step} from "OZ/access/Ownable2Step.sol";
import {Context} from "OZ/utils/Context.sol";
import {RuleERC2980Base} from "../abstract/base/RuleERC2980Base.sol";

/**
 * @title RuleERC2980Ownable2Step
 * @notice Ownable2Step variant of RuleERC2980 with owner-based authorization hooks.
 * @dev All whitelist and frozenlist management functions are restricted to the contract owner.
 */
contract RuleERC2980Ownable2Step is RuleERC2980Base, Ownable2Step {
    /*//////////////////////////////////////////////////////////////
                             CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address owner, address forwarderIrrevocable) RuleERC2980Base(forwarderIrrevocable) Ownable(owner) {}

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    function _authorizeWhitelistAdd() internal view virtual override onlyOwner {}

    function _authorizeWhitelistRemove() internal view virtual override onlyOwner {}

    function _authorizeFrozenlistAdd() internal view virtual override onlyOwner {}

    function _authorizeFrozenlistRemove() internal view virtual override onlyOwner {}

    /*//////////////////////////////////////////////////////////////
                        INTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function _msgSender() internal view virtual override(Context, RuleERC2980Base) returns (address sender) {
        return super._msgSender();
    }

    function _msgData() internal view virtual override(Context, RuleERC2980Base) returns (bytes calldata) {
        return super._msgData();
    }

    function _contextSuffixLength() internal view virtual override(Context, RuleERC2980Base) returns (uint256) {
        return super._contextSuffixLength();
    }
}
