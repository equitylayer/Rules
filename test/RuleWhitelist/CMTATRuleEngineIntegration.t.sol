// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../HelperContract.sol";

/**
 * @title Integration test with CMTAT + RuleEngine + RuleWhitelist
 */
contract CMTATRuleEngineIntegration is Test, HelperContract {
    uint256 ADDRESS1_BALANCE_INIT = 100;

    function setUp() public {
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleWhitelist = new RuleWhitelist(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS, true);

        cmtatDeployment = new CMTATDeployment();
        CMTAT_CONTRACT = cmtatDeployment.cmtat();

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleEngineMock = new RuleEngine(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS, address(CMTAT_CONTRACT));
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleEngineMock.addRule(ruleWhitelist);
        // Allow minting: whitelist ZERO_ADDRESS (mint source) and recipient.
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleWhitelist.addAddress(ZERO_ADDRESS);
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleWhitelist.addAddress(ADDRESS1);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        CMTAT_CONTRACT.setRuleEngine(ruleEngineMock);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        CMTAT_CONTRACT.mint(ADDRESS1, ADDRESS1_BALANCE_INIT);
    }

    function testDetectRestrictionAndCanTransferViaCMTAT() public {
        uint256 amount = 10;

        // Sender already whitelisted in setUp; recipient not whitelisted: should block on TO.
        resUint8 = CMTAT_CONTRACT.detectTransferRestriction(ADDRESS1, ADDRESS2, amount);
        assertEq(resUint8, CODE_ADDRESS_TO_NOT_WHITELISTED);
        resBool = CMTAT_CONTRACT.canTransfer(ADDRESS1, ADDRESS2, amount);
        assertEq(resBool, false);

        // Add recipient: should allow.
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleWhitelist.addAddress(ADDRESS2);
        resUint8 = CMTAT_CONTRACT.detectTransferRestriction(ADDRESS1, ADDRESS2, amount);
        assertEq(resUint8, TRANSFER_OK);
        resBool = CMTAT_CONTRACT.canTransfer(ADDRESS1, ADDRESS2, amount);
        assertEq(resBool, true);
    }

    function testDetectRestrictionFromAndCanTransferFromViaCMTAT() public {
        uint256 amount = 10;

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleWhitelist.addAddress(ADDRESS2);

        // Spender not whitelisted.
        resUint8 = CMTAT_CONTRACT.detectTransferRestrictionFrom(ADDRESS3, ADDRESS1, ADDRESS2, amount);
        assertEq(resUint8, CODE_ADDRESS_SPENDER_NOT_WHITELISTED);
        resBool = CMTAT_CONTRACT.canTransferFrom(ADDRESS3, ADDRESS1, ADDRESS2, amount);
        assertEq(resBool, false);

        // Whitelist spender: should allow.
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleWhitelist.addAddress(ADDRESS3);
        resUint8 = CMTAT_CONTRACT.detectTransferRestrictionFrom(ADDRESS3, ADDRESS1, ADDRESS2, amount);
        assertEq(resUint8, TRANSFER_OK);
        resBool = CMTAT_CONTRACT.canTransferFrom(ADDRESS3, ADDRESS1, ADDRESS2, amount);
        assertEq(resBool, true);
    }
}
