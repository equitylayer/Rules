// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {IIdentityRegistryVerified} from "src/rules/interfaces/IIdentityRegistry.sol";

contract IdentityRegistryMock is IIdentityRegistryVerified {
    mapping(address => bool) private verified;

    /*//////////////////////////////////////////////////////////////
                        EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function setVerified(address user, bool verified_) external {
        verified[user] = verified_;
    }

    function isVerified(address user) external view returns (bool) {
        return verified[user];
    }
}
