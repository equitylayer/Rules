// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Ownable} from "OZ/access/Ownable.sol";
import {Ownable2Step} from "OZ/access/Ownable2Step.sol";
import {IRule} from "RuleEngine/interfaces/IRule.sol";
import {RuleInterfaceId} from "RuleEngine/modules/library/RuleInterfaceId.sol";
import {IERC165} from "OZ/utils/introspection/IERC165.sol";
import {RuleConditionalTransferLightBase} from "./abstract/RuleConditionalTransferLightBase.sol";

/**
 * @title RuleConditionalTransferLightOwnable2Step
 * @notice Ownable2Step variant of RuleConditionalTransferLight.
 */
contract RuleConditionalTransferLightOwnable2Step is
    RuleConditionalTransferLightBase,
    Ownable2Step
{
    constructor(address owner) Ownable(owner) {}

    function supportsInterface(bytes4 interfaceId) public view override returns (bool) {
        return interfaceId == type(IERC165).interfaceId || interfaceId == RuleInterfaceId.IRULE_INTERFACE_ID
            || interfaceId == type(IRule).interfaceId;
    }

    function _authorizeTransferApproval() internal view override onlyOwner {}

    function _authorizeTransferExecution() internal view override onlyOwner {}
}
