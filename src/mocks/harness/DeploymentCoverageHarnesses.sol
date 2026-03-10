// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {ISanctionsList} from "src/rules/interfaces/ISanctionsList.sol";
import {RuleBlacklist} from "src/rules/validation/deployment/RuleBlacklist.sol";
import {RuleWhitelist} from "src/rules/validation/deployment/RuleWhitelist.sol";
import {RuleWhitelistWrapper} from "src/rules/validation/deployment/RuleWhitelistWrapper.sol";
import {RuleERC2980} from "src/rules/validation/deployment/RuleERC2980.sol";
import {RuleSanctionsList} from "src/rules/validation/deployment/RuleSanctionsList.sol";
import {RuleBlacklistOwnable2Step} from "src/rules/validation/deployment/RuleBlacklistOwnable2Step.sol";
import {RuleWhitelistOwnable2Step} from "src/rules/validation/deployment/RuleWhitelistOwnable2Step.sol";
import {RuleWhitelistWrapperOwnable2Step} from "src/rules/validation/deployment/RuleWhitelistWrapperOwnable2Step.sol";
import {RuleERC2980Ownable2Step} from "src/rules/validation/deployment/RuleERC2980Ownable2Step.sol";

contract RuleBlacklistHarness is RuleBlacklist {
    constructor(address admin, address forwarderIrrevocable) RuleBlacklist(admin, forwarderIrrevocable) {}

    function exposedMsgDataLength() external view returns (uint256) {
        return _msgData().length;
    }
}

contract RuleWhitelistHarness is RuleWhitelist {
    constructor(address admin, address forwarderIrrevocable, bool checkSpender_)
        RuleWhitelist(admin, forwarderIrrevocable, checkSpender_)
    {}

    function exposedMsgDataLength() external view returns (uint256) {
        return _msgData().length;
    }
}

contract RuleWhitelistWrapperHarness is RuleWhitelistWrapper {
    constructor(address admin, address forwarderIrrevocable, bool checkSpender_)
        RuleWhitelistWrapper(admin, forwarderIrrevocable, checkSpender_)
    {}

    function exposedMsgDataLength() external view returns (uint256) {
        return _msgData().length;
    }
}

contract RuleERC2980Harness is RuleERC2980 {
    constructor(address admin, address forwarderIrrevocable) RuleERC2980(admin, forwarderIrrevocable) {}

    function exposedMsgDataLength() external view returns (uint256) {
        return _msgData().length;
    }
}

contract RuleSanctionsListHarness is RuleSanctionsList {
    constructor(address admin, address forwarderIrrevocable, ISanctionsList sanctionContractOracle_)
        RuleSanctionsList(admin, forwarderIrrevocable, sanctionContractOracle_)
    {}

    function exposedMsgDataLength() external view returns (uint256) {
        return _msgData().length;
    }
}

contract RuleBlacklistOwnable2StepHarness is RuleBlacklistOwnable2Step {
    constructor(address owner, address forwarderIrrevocable) RuleBlacklistOwnable2Step(owner, forwarderIrrevocable) {}

    function exposedMsgDataLength() external view returns (uint256) {
        return _msgData().length;
    }
}

contract RuleWhitelistOwnable2StepHarness is RuleWhitelistOwnable2Step {
    constructor(address owner, address forwarderIrrevocable, bool checkSpender_)
        RuleWhitelistOwnable2Step(owner, forwarderIrrevocable, checkSpender_)
    {}

    function exposedMsgDataLength() external view returns (uint256) {
        return _msgData().length;
    }
}

contract RuleWhitelistWrapperOwnable2StepHarness is RuleWhitelistWrapperOwnable2Step {
    constructor(address owner, address forwarderIrrevocable, bool checkSpender_)
        RuleWhitelistWrapperOwnable2Step(owner, forwarderIrrevocable, checkSpender_)
    {}

    function exposedMsgDataLength() external view returns (uint256) {
        return _msgData().length;
    }
}

contract RuleERC2980Ownable2StepHarness is RuleERC2980Ownable2Step {
    constructor(address owner, address forwarderIrrevocable) RuleERC2980Ownable2Step(owner, forwarderIrrevocable) {}

    function exposedMsgDataLength() external view returns (uint256) {
        return _msgData().length;
    }
}
