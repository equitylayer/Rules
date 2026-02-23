// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../HelperContract.sol";
import "../utils/TotalSupplyMock.sol";

/**
 * @title Integration test between RuleEngine and RuleMaxTotalSupply
 */
contract RuleMaxTotalSupplyRuleEngineIntegration is Test, HelperContract {
    TotalSupplyMock token;

    function setUp() public {
        token = new TotalSupplyMock();

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleEngineMock = new RuleEngine(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS, ZERO_ADDRESS);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleMaxTotalSupply = new RuleMaxTotalSupply(DEFAULT_ADMIN_ADDRESS, address(token), 100);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleEngineMock.addRule(ruleMaxTotalSupply);
    }

    function testDetectRestrictionForMintExceedingMaxSupply() public {
        token.setTotalSupply(90);
        resUint8 = ruleEngineMock.detectTransferRestriction(address(0), ADDRESS1, 15);
        assertEq(resUint8, CODE_MAX_TOTAL_SUPPLY_EXCEEDED);
        resBool = ruleEngineMock.canTransfer(address(0), ADDRESS1, 15);
        assertEq(resBool, false);
    }

    function testDetectRestrictionForMintWithinMaxSupply() public {
        token.setTotalSupply(90);
        resUint8 = ruleEngineMock.detectTransferRestriction(address(0), ADDRESS1, 10);
        assertEq(resUint8, TRANSFER_OK);
        resBool = ruleEngineMock.canTransfer(address(0), ADDRESS1, 10);
        assertEq(resBool, true);
    }

    function testTransfersNotAffectedByMaxSupplyRule() public {
        token.setTotalSupply(100);
        resUint8 = ruleEngineMock.detectTransferRestriction(ADDRESS1, ADDRESS2, 50);
        assertEq(resUint8, TRANSFER_OK);
        resBool = ruleEngineMock.canTransfer(ADDRESS1, ADDRESS2, 50);
        assertEq(resBool, true);
    }
}
