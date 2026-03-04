// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {ITransferContext} from "src/rules/interfaces/ITransferContext.sol";

contract MockERC20WithTransferContext {
    string public name;
    string public symbol;
    uint8 public immutable decimals;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    ITransferContext public rule;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory name_, string memory symbol_) {
        name = name_;
        symbol = symbol_;
        decimals = 18;
    }

    function setRule(address rule_) external {
        rule = ITransferContext(rule_);
    }

    function mint(address to, uint256 value) external {
        balanceOf[to] += value;
        emit Transfer(address(0), to, value);
    }

    function approve(address spender, uint256 value) external returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transfer(address to, uint256 value) external returns (bool) {
        _transfer(msg.sender, to, value);
        _callRuleContext(msg.sender, to, value, address(0), true, 0);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        uint256 allowed = allowance[from][msg.sender];
        require(allowed >= value, "ALLOWANCE");
        allowance[from][msg.sender] = allowed - value;
        _transfer(from, to, value);
        _callRuleContext(from, to, value, msg.sender, true, 0);
        return true;
    }

    function transferWithContext(address to, uint256 value, bool useFungibleContext, uint256 tokenId)
        external
        returns (bool)
    {
        _transfer(msg.sender, to, value);
        _callRuleContext(msg.sender, to, value, address(0), useFungibleContext, tokenId);
        return true;
    }

    function transferFromWithContext(
        address from,
        address to,
        uint256 value,
        bool useFungibleContext,
        uint256 tokenId
    ) external returns (bool) {
        uint256 allowed = allowance[from][msg.sender];
        require(allowed >= value, "ALLOWANCE");
        allowance[from][msg.sender] = allowed - value;
        _transfer(from, to, value);
        _callRuleContext(from, to, value, msg.sender, useFungibleContext, tokenId);
        return true;
    }

    function _transfer(address from, address to, uint256 value) internal {
        require(balanceOf[from] >= value, "BALANCE");
        balanceOf[from] -= value;
        balanceOf[to] += value;
        emit Transfer(from, to, value);
    }

    function _callRuleContext(
        address from,
        address to,
        uint256 value,
        address sender,
        bool useFungibleContext,
        uint256 tokenId
    ) internal {
        if (address(rule) == address(0)) {
            return;
        }

        if (useFungibleContext) {
            ITransferContext.TransferContextFungible memory ctx =
                ITransferContext.TransferContextFungible({
                    selector: sender == address(0)
                        ? bytes4(keccak256("transferred(address,address,uint256)"))
                        : bytes4(keccak256("transferred(address,address,address,uint256)")),
                    sender: sender,
                    from: from,
                    to: to,
                    value: value
                });
            rule.transferred(ctx);
        } else {
            ITransferContext.TransferContext memory ctx =
                ITransferContext.TransferContext({
                    selector: sender == address(0)
                        ? bytes4(keccak256("transferred(address,address,uint256)"))
                        : bytes4(keccak256("transferred(address,address,address,uint256)")),
                    sender: sender,
                    from: from,
                    to: to,
                    value: value,
                    tokenId: tokenId
                });
            rule.transferred(ctx);
        }
    }
}
