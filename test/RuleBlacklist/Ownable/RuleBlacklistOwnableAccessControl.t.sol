// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import "../../utils/OwnableAddressListTestBase.sol";
import {RuleBlacklistOwnable} from "src/rules/validation/RuleBlacklistOwnable.sol";

contract RuleBlacklistOwnableAccessControl is OwnableAddressListTestBase {
    function _deployAddressList() internal override returns (IAddressList, address) {
        address ownerAddr = WHITELIST_OPERATOR_ADDRESS;
        RuleBlacklistOwnable rule = new RuleBlacklistOwnable(ownerAddr, ZERO_ADDRESS);
        return (IAddressList(address(rule)), ownerAddr);
    }
}
