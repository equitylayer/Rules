// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {IIdentityRegistryVerified} from "src/rules/interfaces/IIdentityRegistry.sol";

contract IdentityRegistryMock is IIdentityRegistryVerified {
    mapping(address => bool) private verified;

    function setVerified(address user, bool isVerified) external {
        verified[user] = isVerified;
    }

    function isVerified(address user) external view returns (bool) {
        return verified[user];
    }
}
