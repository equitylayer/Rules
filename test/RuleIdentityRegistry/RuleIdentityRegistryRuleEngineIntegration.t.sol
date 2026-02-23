// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../HelperContract.sol";
import "../utils/IdentityRegistryMock.sol";

/**
 * @title Integration test between RuleEngine and RuleIdentityRegistry
 */
contract RuleIdentityRegistryRuleEngineIntegration is Test, HelperContract {
    IdentityRegistryMock registry;

    function setUp() public {
        registry = new IdentityRegistryMock();

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleEngineMock = new RuleEngine(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS, ZERO_ADDRESS);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleIdentityRegistry = new RuleIdentityRegistry(DEFAULT_ADMIN_ADDRESS, address(registry));

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleEngineMock.addRule(ruleIdentityRegistry);
    }

    function testDetectRestrictionWhenNotVerified() public {
        uint256 amount = 10;
        resUint8 = ruleEngineMock.detectTransferRestriction(ADDRESS1, ADDRESS2, amount);
        assertEq(resUint8, CODE_ADDRESS_FROM_NOT_VERIFIED);
        resBool = ruleEngineMock.canTransfer(ADDRESS1, ADDRESS2, amount);
        assertEq(resBool, false);
    }

    function testDetectRestrictionWhenVerified() public {
        uint256 amount = 10;
        registry.setVerified(ADDRESS1, true);
        registry.setVerified(ADDRESS2, true);

        resUint8 = ruleEngineMock.detectTransferRestriction(ADDRESS1, ADDRESS2, amount);
        assertEq(resUint8, TRANSFER_OK);
        resBool = ruleEngineMock.canTransfer(ADDRESS1, ADDRESS2, amount);
        assertEq(resBool, true);
    }

    function testDetectRestrictionFromWithSpender() public {
        uint256 amount = 10;
        registry.setVerified(ADDRESS1, true);
        registry.setVerified(ADDRESS2, true);

        resUint8 = ruleEngineMock.detectTransferRestrictionFrom(ADDRESS3, ADDRESS1, ADDRESS2, amount);
        assertEq(resUint8, CODE_ADDRESS_SPENDER_NOT_VERIFIED);
        resBool = ruleEngineMock.canTransferFrom(ADDRESS3, ADDRESS1, ADDRESS2, amount);
        assertEq(resBool, false);

        registry.setVerified(ADDRESS3, true);
        resUint8 = ruleEngineMock.detectTransferRestrictionFrom(ADDRESS3, ADDRESS1, ADDRESS2, amount);
        assertEq(resUint8, TRANSFER_OK);
        resBool = ruleEngineMock.canTransferFrom(ADDRESS3, ADDRESS1, ADDRESS2, amount);
        assertEq(resBool, true);
    }
}
