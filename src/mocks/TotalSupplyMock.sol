// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

contract TotalSupplyMock {
    uint256 private _totalSupply;

    /*//////////////////////////////////////////////////////////////
                        EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function setTotalSupply(uint256 newTotalSupply) external {
        _totalSupply = newTotalSupply;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }
}
