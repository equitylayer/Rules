// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {ISanctionsList} from "src/rules/interfaces/ISanctionsList.sol";
import {RuleSanctionsListOwnable2Step} from "src/rules/validation/deployment/RuleSanctionsListOwnable2Step.sol";

contract RuleSanctionsListOwnable2StepHarness is RuleSanctionsListOwnable2Step {
    constructor(address owner, address forwarderIrrevocable, ISanctionsList sanctionContractOracle_)
        RuleSanctionsListOwnable2Step(owner, forwarderIrrevocable, sanctionContractOracle_)
    {}

    function exposedMsgSender() external view returns (address) {
        return _msgSender();
    }

    function exposedMsgData() external view returns (bytes memory) {
        return _msgData();
    }

    function exposedContextSuffixLength() external view returns (uint256) {
        return _contextSuffixLength();
    }
}
