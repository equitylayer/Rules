// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../HelperContract.sol";
import {MinimalForwarderMock} from "CMTAT/mocks/MinimalForwarderMock.sol";
import {AccessControlModuleStandalone} from "../../src/modules/AccessControlModuleStandalone.sol";
import {RuleWhitelist} from "src/rules/validation/deployment/RuleWhitelist.sol";
/**
 * @title General functions of the RuleWhitelist
 */

contract RuleWhitelistDeploymentTest is Test, HelperContract {
    // Arrange
    function setUp() public {}

    function testRightDeployment() public {
        // Arrange
        vm.prank(WHITELIST_OPERATOR_ADDRESS);
        MinimalForwarderMock forwarder = new MinimalForwarderMock();
        forwarder.initialize(ERC2771ForwarderDomain);
        vm.prank(WHITELIST_OPERATOR_ADDRESS);
        ruleWhitelist = new RuleWhitelist(WHITELIST_OPERATOR_ADDRESS, address(forwarder), true, false);

        // assert
        resBool = ruleWhitelist.hasRole(ADDRESS_LIST_ADD_ROLE, WHITELIST_OPERATOR_ADDRESS);
        assertEq(resBool, true);
        resBool = ruleWhitelist.hasRole(ADDRESS_LIST_REMOVE_ROLE, WHITELIST_OPERATOR_ADDRESS);
        assertEq(resBool, true);
        resBool = ruleWhitelist.isTrustedForwarder(address(forwarder));
        assertEq(resBool, true);
    }

    function testCannotDeployContractIfAdminAddressIsZero() public {
        // Arrange
        vm.prank(WHITELIST_OPERATOR_ADDRESS);
        MinimalForwarderMock forwarder = new MinimalForwarderMock();
        forwarder.initialize(ERC2771ForwarderDomain);
        vm.expectRevert(AccessControlModuleStandalone.AccessControlModuleStandalone_AddressZeroNotAllowed.selector);
        vm.prank(WHITELIST_OPERATOR_ADDRESS);
        ruleWhitelist = new RuleWhitelist(address(0), address(forwarder), true, false);
    }
}
