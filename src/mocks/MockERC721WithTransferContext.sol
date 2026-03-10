// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {ERC721} from "OZ/token/ERC721/ERC721.sol";
import {ITransferContext} from "src/rules/interfaces/ITransferContext.sol";

contract MockERC721WithTransferContext is ERC721 {
    ITransferContext public rule;

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {}

    function setRule(address rule_) external {
        rule = ITransferContext(rule_);
    }

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) public virtual override {
        address sender = _msgSender();
        super.transferFrom(from, to, tokenId);
        _notifyRule(sender, from, to, tokenId);
    }

    function _notifyRule(address sender, address from, address to, uint256 tokenId) internal {
        if (address(rule) == address(0)) {
            return;
        }

        ITransferContext.MultiTokenTransferContext memory ctx = ITransferContext.MultiTokenTransferContext({
            selector: this.transferFrom.selector,
            sender: sender,
            from: from,
            to: to,
            value: 1,
            tokenId: tokenId,
            data: ""
        });
        rule.transferred(ctx);
    }
}
