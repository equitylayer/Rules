// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Ownable} from "OZ/access/Ownable.sol";
import {Ownable2Step} from "OZ/access/Ownable2Step.sol";
import {IRule} from "RuleEngine/interfaces/IRule.sol";
import {RuleInterfaceId} from "RuleEngine/modules/library/RuleInterfaceId.sol";
import {RuleConditionalTransferLightBase} from "./abstract/RuleConditionalTransferLightBase.sol";

/**
 * @title RuleConditionalTransferLightOwnable2Step
 * @notice Ownable2Step variant of RuleConditionalTransferLight.
 */
contract RuleConditionalTransferLightOwnable2Step is
    RuleConditionalTransferLightBase,
    Ownable2Step
{
    address public transferApprover;
    address public transferExecutor;

    constructor(address owner, address transferApprover_, address transferExecutor_) Ownable(owner) {
        _setTransferApprover(transferApprover_);
        _setTransferExecutor(transferExecutor_);
    }

    function supportsInterface(bytes4 interfaceId) public view returns (bool) {
        return interfaceId == RuleInterfaceId.IRULE_INTERFACE_ID || interfaceId == type(IRule).interfaceId;
    }

    function setTransferApprover(address newApprover) external onlyOwner {
        _setTransferApprover(newApprover);
    }

    function setTransferExecutor(address newExecutor) external onlyOwner {
        _setTransferExecutor(newExecutor);
    }

    function _authorizeTransferApproval() internal view override {
        require(
            _msgSender() == owner() || _msgSender() == transferApprover,
            RuleConditionalTransferLight_TransferApproverUnauthorized(_msgSender())
        );
    }

    function _authorizeTransferExecution() internal view override {
        require(
            _msgSender() == owner() || _msgSender() == transferExecutor,
            RuleConditionalTransferLight_TransferExecutorUnauthorized(_msgSender())
        );
    }

    function _setTransferApprover(address newApprover) internal {
        transferApprover = newApprover == address(0) ? owner() : newApprover;
    }

    function _setTransferExecutor(address newExecutor) internal {
        transferExecutor = newExecutor == address(0) ? owner() : newExecutor;
    }
}
