// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

contract MockERC20TransferFromFalse {
    mapping(address => mapping(address => uint256)) private _allowances;

    /*//////////////////////////////////////////////////////////////
                        EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function setAllowance(address owner, address spender, uint256 value) external {
        _allowances[owner][spender] = value;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }

    function transferFrom(address, address, uint256) external pure returns (bool) {
        return false;
    }
}
