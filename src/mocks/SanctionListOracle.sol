// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {ISanctionsList} from "src/rules/interfaces/ISanctionsList.sol";

contract SanctionListOracle is ISanctionsList {
    mapping(address => bool) private sanctionedAddresses;

    /*//////////////////////////////////////////////////////////////
                        PUBLIC FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function addToSanctionsList(address newSanction) public {
        sanctionedAddresses[newSanction] = true;
    }

    function removeFromSanctionsList(address removeSanction) public {
        sanctionedAddresses[removeSanction] = true;
    }

    function isSanctioned(address addr) public view returns (bool) {
        return sanctionedAddresses[addr];
    }
}
