// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {ERC20} from "OZ/token/ERC20/ERC20.sol";
import {ITransferContext} from "src/rules/interfaces/ITransferContext.sol";

contract MockERC20WithTransferContext is ERC20 {
    ITransferContext public rule;

    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_) {}

    function setRule(address rule_) external {
        rule = ITransferContext(rule_);
    }

    function mint(address to, uint256 value) external {
        _mint(to, value);
    }

    function transfer(address to, uint256 value) public virtual override returns (bool) {
        bool success = super.transfer(to, value);
        _notifyFungible(_msgSender(), _msgSender(), to, value);
        return success;
    }

    function transferFrom(address from, address to, uint256 value) public virtual override returns (bool) {
        address sender = _msgSender();
        bool success = super.transferFrom(from, to, value);
        _notifyFungible(sender, from, to, value);
        return success;
    }

    function transferWithContext(address to, uint256 value, bool useFungibleContext, uint256 tokenId)
        external
        returns (bool)
    {
        _transfer(_msgSender(), to, value);
        if (useFungibleContext) {
            _notifyFungible(_msgSender(), _msgSender(), to, value);
        } else {
            _notifyMultiToken(_msgSender(), _msgSender(), to, value, tokenId);
        }
        return true;
    }

    function transferFromWithContext(address from, address to, uint256 value, bool useFungibleContext, uint256 tokenId)
        external
        returns (bool)
    {
        address sender = _msgSender();
        _spendAllowance(from, sender, value);
        _transfer(from, to, value);

        if (useFungibleContext) {
            _notifyFungible(sender, from, to, value);
        } else {
            _notifyMultiToken(sender, from, to, value, tokenId);
        }
        return true;
    }

    function _notifyFungible(address sender, address from, address to, uint256 value) internal {
        if (address(rule) == address(0)) {
            return;
        }

        ITransferContext.FungibleTransferContext memory ctx = ITransferContext.FungibleTransferContext({
            selector: sender == from ? this.transfer.selector : this.transferFrom.selector,
            sender: sender,
            from: from,
            to: to,
            value: value,
            data: ""
        });
        rule.transferred(ctx);
    }

    function _notifyMultiToken(address sender, address from, address to, uint256 value, uint256 tokenId) internal {
        if (address(rule) == address(0)) {
            return;
        }

        ITransferContext.MultiTokenTransferContext memory ctx = ITransferContext.MultiTokenTransferContext({
            selector: sender == from ? this.transfer.selector : this.transferFrom.selector,
            sender: sender,
            from: from,
            to: to,
            value: value,
            tokenId: tokenId,
            data: ""
        });
        rule.transferred(ctx);
    }
}
