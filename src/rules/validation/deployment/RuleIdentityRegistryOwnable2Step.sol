// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Ownable} from "OZ/access/Ownable.sol";
import {Ownable2Step} from "OZ/access/Ownable2Step.sol";
import {RuleIdentityRegistryBase} from "../abstract/base/RuleIdentityRegistryBase.sol";

/**
 * @title RuleIdentityRegistryOwnable2Step
 * @notice Ownable2Step variant of RuleIdentityRegistry.
 */
contract RuleIdentityRegistryOwnable2Step is RuleIdentityRegistryBase, Ownable2Step {
    /*//////////////////////////////////////////////////////////////
                             CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address owner, address identityRegistry_) RuleIdentityRegistryBase(identityRegistry_) Ownable(owner) {}

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    function _authorizeIdentityRegistryManager() internal view virtual override onlyOwner {}
}
