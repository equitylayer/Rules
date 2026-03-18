// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {RuleSpenderWhitelist} from "src/rules/validation/deployment/RuleSpenderWhitelist.sol";
import {RuleSpenderWhitelistOwnable2Step} from "src/rules/validation/deployment/RuleSpenderWhitelistOwnable2Step.sol";

contract RuleSpenderWhitelistHarness is RuleSpenderWhitelist {
    /*//////////////////////////////////////////////////////////////
                             CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address admin, address forwarderIrrevocable) RuleSpenderWhitelist(admin, forwarderIrrevocable) {}

    /*//////////////////////////////////////////////////////////////
                        EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

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

contract RuleSpenderWhitelistOwnable2StepHarness is RuleSpenderWhitelistOwnable2Step {
    /*//////////////////////////////////////////////////////////////
                             CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address owner, address forwarderIrrevocable)
        RuleSpenderWhitelistOwnable2Step(owner, forwarderIrrevocable)
    {}

    /*//////////////////////////////////////////////////////////////
                        EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

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
