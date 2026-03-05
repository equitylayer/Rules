// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Ownable} from "OZ/access/Ownable.sol";
import {Ownable2Step} from "OZ/access/Ownable2Step.sol";
import {RuleMaxTotalSupplyBase} from "../abstract/base/RuleMaxTotalSupplyBase.sol";

/**
 * @title RuleMaxTotalSupplyOwnable2Step
 * @notice Ownable2Step variant of RuleMaxTotalSupply.
 */
contract RuleMaxTotalSupplyOwnable2Step is RuleMaxTotalSupplyBase, Ownable2Step {
    constructor(address owner, address tokenContract_, uint256 maxTotalSupply_)
        RuleMaxTotalSupplyBase(tokenContract_, maxTotalSupply_)
        Ownable(owner)
    {}

    function _authorizeMaxTotalSupplyManager() internal view override onlyOwner {}
}
