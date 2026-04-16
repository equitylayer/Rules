// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {RuleWhitelistWrapper} from "src/rules/validation/deployment/RuleWhitelistWrapper.sol";

contract RuleWhitelistWrapperHarnessInternal is RuleWhitelistWrapper {
    /*//////////////////////////////////////////////////////////////
                             CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address admin, address forwarderIrrevocable, bool checkSpender_)
        RuleWhitelistWrapper(admin, forwarderIrrevocable, checkSpender_)
    {}

    /*//////////////////////////////////////////////////////////////
                        EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function exposedTransferredSpenderInternal(address spender, address from, address to, uint256 value) external view {
        _transferred(spender, from, to, value);
    }
}
