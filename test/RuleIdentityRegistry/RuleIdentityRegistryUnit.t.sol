// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../HelperContract.sol";
import {RuleIdentityRegistry} from "src/rules/validation/deployment/RuleIdentityRegistry.sol";
import {IdentityRegistryMock} from "../utils/IdentityRegistryMock.sol";

contract RuleIdentityRegistryUnit is Test, HelperContract {
    IdentityRegistryMock private registry;
    RuleIdentityRegistry private rule;

    function setUp() public {
        registry = new IdentityRegistryMock();
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule = new RuleIdentityRegistry(DEFAULT_ADMIN_ADDRESS, address(registry));
    }

    function testDetectRestriction_NoRegistry_ReturnsOk() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule = new RuleIdentityRegistry(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS);

        resUint8 = rule.detectTransferRestriction(ADDRESS1, ADDRESS2, 1);
        assertEq(resUint8, TRANSFER_OK);
    }

    function testDetectRestriction_FromNotVerified() public {
        registry.setVerified(ADDRESS2, true);

        resUint8 = rule.detectTransferRestriction(ADDRESS1, ADDRESS2, 1);
        assertEq(resUint8, CODE_ADDRESS_FROM_NOT_VERIFIED);
    }

    function testDetectRestriction_ToNotVerified() public {
        registry.setVerified(ADDRESS1, true);

        resUint8 = rule.detectTransferRestriction(ADDRESS1, ADDRESS2, 1);
        assertEq(resUint8, CODE_ADDRESS_TO_NOT_VERIFIED);
    }

    function testDetectRestriction_BurnAllowed() public {
        resUint8 = rule.detectTransferRestriction(ADDRESS1, ZERO_ADDRESS, 1);
        assertEq(resUint8, TRANSFER_OK);
    }

    function testDetectRestrictionFrom_SpenderNotVerified() public {
        registry.setVerified(ADDRESS1, true);
        registry.setVerified(ADDRESS2, true);

        resUint8 = rule.detectTransferRestrictionFrom(ADDRESS3, ADDRESS1, ADDRESS2, 1);
        assertEq(resUint8, CODE_ADDRESS_SPENDER_NOT_VERIFIED);
    }

    function testSetIdentityRegistry_RevertsOnZeroAddress() public {
        vm.expectRevert(RuleIdentityRegistry_RegistryAddressZeroNotAllowed.selector);
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.setIdentityRegistry(ZERO_ADDRESS);
    }

    function testSetIdentityRegistry_OnlyAdmin() public {
        vm.expectRevert();
        vm.prank(ADDRESS1);
        rule.setIdentityRegistry(address(registry));
    }

    function testClearIdentityRegistry_OnlyAdmin() public {
        vm.expectRevert();
        vm.prank(ADDRESS1);
        rule.clearIdentityRegistry();
    }

    function testTransferred_RevertsOnInvalidTransfer() public {
        registry.setVerified(ADDRESS2, true);

        vm.expectRevert(
            abi.encodeWithSelector(
                RuleIdentityRegistry_InvalidTransfer.selector,
                address(rule),
                ADDRESS1,
                ADDRESS2,
                10,
                CODE_ADDRESS_FROM_NOT_VERIFIED
            )
        );
        rule.transferred(ADDRESS1, ADDRESS2, 10);
    }

    function testTransferredFrom_RevertsOnInvalidTransfer() public {
        registry.setVerified(ADDRESS1, true);
        registry.setVerified(ADDRESS2, true);

        vm.expectRevert(
            abi.encodeWithSelector(
                RuleIdentityRegistry_InvalidTransferFrom.selector,
                address(rule),
                ADDRESS3,
                ADDRESS1,
                ADDRESS2,
                10,
                CODE_ADDRESS_SPENDER_NOT_VERIFIED
            )
        );
        rule.transferred(ADDRESS3, ADDRESS1, ADDRESS2, 10);
    }
}
