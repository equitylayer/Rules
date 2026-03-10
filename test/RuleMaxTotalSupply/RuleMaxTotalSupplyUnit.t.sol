// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../HelperContract.sol";
import {RuleMaxTotalSupply} from "src/rules/validation/deployment/RuleMaxTotalSupply.sol";
import {TotalSupplyMock} from "src/mocks/TotalSupplyMock.sol";

contract RuleMaxTotalSupplyUnit is Test, HelperContract {
    TotalSupplyMock private token;
    RuleMaxTotalSupply private rule;

    function setUp() public {
        token = new TotalSupplyMock();
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule = new RuleMaxTotalSupply(DEFAULT_ADMIN_ADDRESS, address(token), 100);
    }

    function testConstructor_RevertsOnZeroToken() public {
        vm.expectRevert(RuleMaxTotalSupply_TokenAddressZeroNotAllowed.selector);
        new RuleMaxTotalSupply(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS, 100);
    }

    function testSetTokenContract_RevertsOnZero() public {
        vm.expectRevert(RuleMaxTotalSupply_TokenAddressZeroNotAllowed.selector);
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.setTokenContract(ZERO_ADDRESS);
    }

    function testSetTokenContract_OnlyAdmin() public {
        vm.expectRevert();
        vm.prank(ADDRESS1);
        rule.setTokenContract(address(token));
    }

    function testSetMaxTotalSupply_OnlyAdmin() public {
        vm.expectRevert();
        vm.prank(ADDRESS1);
        rule.setMaxTotalSupply(200);
    }

    function testDetectRestriction_MintExceedsMaxSupply() public {
        token.setTotalSupply(90);
        resUint8 = rule.detectTransferRestriction(ZERO_ADDRESS, ADDRESS1, 11);
        assertEq(resUint8, CODE_MAX_TOTAL_SUPPLY_EXCEEDED);
    }

    function testDetectRestriction_MintWithinMaxSupply() public {
        token.setTotalSupply(90);
        resUint8 = rule.detectTransferRestriction(ZERO_ADDRESS, ADDRESS1, 10);
        assertEq(resUint8, TRANSFER_OK);
    }

    function testDetectRestriction_NonMintTransfer() public {
        token.setTotalSupply(100);
        resUint8 = rule.detectTransferRestriction(ADDRESS1, ADDRESS2, 50);
        assertEq(resUint8, TRANSFER_OK);
    }

    function testTransferred_RevertsOnInvalidTransfer() public {
        token.setTotalSupply(100);
        vm.expectRevert(
            abi.encodeWithSelector(
                RuleMaxTotalSupply_InvalidTransfer.selector,
                address(rule),
                ZERO_ADDRESS,
                ADDRESS1,
                1,
                CODE_MAX_TOTAL_SUPPLY_EXCEEDED
            )
        );
        rule.transferred(ZERO_ADDRESS, ADDRESS1, 1);
    }

    function testTransferredFrom_RevertsOnInvalidTransfer() public {
        token.setTotalSupply(100);
        vm.expectRevert(
            abi.encodeWithSelector(
                RuleMaxTotalSupply_InvalidTransferFrom.selector,
                address(rule),
                ADDRESS3,
                ZERO_ADDRESS,
                ADDRESS1,
                1,
                CODE_MAX_TOTAL_SUPPLY_EXCEEDED
            )
        );
        rule.transferred(ADDRESS3, ZERO_ADDRESS, ADDRESS1, 1);
    }

    function testTransferred_DoesNotRevertWhenValid() public {
        token.setTotalSupply(90);
        rule.transferred(ZERO_ADDRESS, ADDRESS1, 10);
    }

    function testTransferredFrom_DoesNotRevertWhenValid() public {
        token.setTotalSupply(90);
        rule.transferred(ADDRESS3, ZERO_ADDRESS, ADDRESS1, 10);
    }

    function testCanReturnTransferRestrictionCode() public view {
        assertTrue(rule.canReturnTransferRestrictionCode(CODE_MAX_TOTAL_SUPPLY_EXCEEDED));
        assertFalse(rule.canReturnTransferRestrictionCode(CODE_NONEXISTENT));
    }

    function testMessageForTransferRestriction() public view {
        assertEq(rule.messageForTransferRestriction(CODE_MAX_TOTAL_SUPPLY_EXCEEDED), TEXT_MAX_TOTAL_SUPPLY_EXCEEDED);
        assertEq(rule.messageForTransferRestriction(CODE_NONEXISTENT), TEXT_CODE_NOT_FOUND);
    }
}
