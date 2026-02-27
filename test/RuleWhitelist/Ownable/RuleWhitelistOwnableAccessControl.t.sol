// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {OwnableAddressListTestBase} from "../../utils/OwnableAddressListTestBase.sol";
import {IAddressList} from "src/rules/interfaces/IAddressList.sol";
import {RuleWhitelistOwnable} from "src/rules/validation/RuleWhitelistOwnable.sol";

contract RuleWhitelistOwnableAccessControl is OwnableAddressListTestBase {
    function _deployAddressList() internal override returns (IAddressList, address) {
        address ownerAddr = WHITELIST_OPERATOR_ADDRESS;
        RuleWhitelistOwnable rule = new RuleWhitelistOwnable(ownerAddr, ZERO_ADDRESS, true);
        return (IAddressList(address(rule)), ownerAddr);
    }
}
