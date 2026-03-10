// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../HelperContract.sol";
import {MockERC20WithTransferContext} from "src/mocks/MockERC20WithTransferContext.sol";
import {MockERC721WithTransferContext} from "src/mocks/MockERC721WithTransferContext.sol";
import {RuleWhitelist} from "src/rules/validation/deployment/RuleWhitelist.sol";
import {RuleSpenderWhitelist} from "src/rules/validation/deployment/RuleSpenderWhitelist.sol";

contract TransferContextMocksTest is Test, HelperContract {
    MockERC20WithTransferContext private erc20;
    MockERC721WithTransferContext private erc721;

    function setUp() public {
        erc20 = new MockERC20WithTransferContext("Mock20", "M20");
        erc721 = new MockERC721WithTransferContext("Mock721", "M721");
    }

    function _deployWhitelistRule() internal returns (RuleWhitelist) {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        RuleWhitelist rule = new RuleWhitelist(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS, false);
        vm.startPrank(DEFAULT_ADMIN_ADDRESS);
        rule.addAddress(ADDRESS1);
        rule.addAddress(ADDRESS2);
        vm.stopPrank();
        return rule;
    }

    function _deploySpenderWhitelistRule() internal returns (RuleSpenderWhitelist) {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        return new RuleSpenderWhitelist(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS);
    }

    function testERC20TransferWithContextWhitelist() public {
        RuleWhitelist rule = _deployWhitelistRule();
        erc20.setRule(address(rule));
        erc20.mint(ADDRESS1, 100);

        vm.prank(ADDRESS1);
        assertTrue(erc20.transfer(ADDRESS2, 10));

        assertEq(erc20.balanceOf(ADDRESS1), 90);
        assertEq(erc20.balanceOf(ADDRESS2), 10);
    }

    function testERC20TransferFromOwnerPathNotTreatedAsSpender() public {
        RuleSpenderWhitelist rule = _deploySpenderWhitelistRule();
        erc20.setRule(address(rule));
        erc20.mint(ADDRESS1, 100);

        vm.prank(ADDRESS1);
        erc20.approve(ADDRESS1, 10);

        vm.prank(ADDRESS1);
        assertTrue(erc20.transferFrom(ADDRESS1, ADDRESS2, 10));

        assertEq(erc20.balanceOf(ADDRESS1), 90);
        assertEq(erc20.balanceOf(ADDRESS2), 10);
    }

    function testERC20TransferFromRequiresSpenderWhitelist() public {
        RuleSpenderWhitelist rule = _deploySpenderWhitelistRule();
        erc20.setRule(address(rule));
        erc20.mint(ADDRESS1, 100);

        vm.prank(ADDRESS1);
        erc20.approve(ADDRESS3, 20);

        vm.expectRevert();
        vm.prank(ADDRESS3);
        erc20.transferFrom(ADDRESS1, ADDRESS2, 10);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.addAddress(ADDRESS3);

        vm.prank(ADDRESS3);
        assertTrue(erc20.transferFrom(ADDRESS1, ADDRESS2, 10));

        assertEq(erc20.balanceOf(ADDRESS1), 90);
        assertEq(erc20.balanceOf(ADDRESS2), 10);
    }

    function testERC721TransferWithContextWhitelist() public {
        RuleWhitelist rule = _deployWhitelistRule();
        erc721.setRule(address(rule));
        erc721.mint(ADDRESS1, 1);

        vm.prank(ADDRESS1);
        erc721.transferFrom(ADDRESS1, ADDRESS2, 1);

        assertEq(erc721.ownerOf(1), ADDRESS2);
        assertEq(erc721.balanceOf(ADDRESS1), 0);
        assertEq(erc721.balanceOf(ADDRESS2), 1);
    }

    function testERC721TransferFromOwnerPathNotTreatedAsSpender() public {
        RuleSpenderWhitelist rule = _deploySpenderWhitelistRule();
        erc721.setRule(address(rule));
        erc721.mint(ADDRESS1, 1);

        vm.prank(ADDRESS1);
        erc721.transferFrom(ADDRESS1, ADDRESS2, 1);
        assertEq(erc721.ownerOf(1), ADDRESS2);
    }

    function testERC721TransferFromRequiresSpenderWhitelist() public {
        RuleSpenderWhitelist rule = _deploySpenderWhitelistRule();
        erc721.setRule(address(rule));
        erc721.mint(ADDRESS1, 1);

        vm.prank(ADDRESS1);
        erc721.approve(ADDRESS3, 1);

        vm.expectRevert();
        vm.prank(ADDRESS3);
        erc721.transferFrom(ADDRESS1, ADDRESS2, 1);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.addAddress(ADDRESS3);

        vm.prank(ADDRESS3);
        erc721.transferFrom(ADDRESS1, ADDRESS2, 1);

        assertEq(erc721.ownerOf(1), ADDRESS2);
    }
}
