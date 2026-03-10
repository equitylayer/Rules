// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../../HelperContract.sol";
import {Ownable} from "OZ/access/Ownable.sol";
import {RuleSpenderWhitelistOwnable2Step} from "src/rules/validation/deployment/RuleSpenderWhitelistOwnable2Step.sol";

contract RuleSpenderWhitelistOwnable2StepHarness is RuleSpenderWhitelistOwnable2Step {
    constructor(address owner, address forwarderIrrevocable) RuleSpenderWhitelistOwnable2Step(owner, forwarderIrrevocable) {}

    function exposedMsgSender() external view returns (address) {
        return _msgSender();
    }

    function exposedMsgData() external view returns (bytes memory) {
        return _msgData();
    }

    function exposedContextSuffixLength() external view returns (uint256) {
        return _contextSuffixLength();
    }
}

contract RuleSpenderWhitelistOwnable2StepTest is Test, HelperContract {
    RuleSpenderWhitelistOwnable2StepHarness private rule;

    function setUp() public {
        rule = new RuleSpenderWhitelistOwnable2StepHarness(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS);
    }

    function testOnlyOwnerCanManageList() public {
        vm.expectRevert();
        vm.prank(ADDRESS1);
        rule.addAddress(ADDRESS3);

        vm.expectRevert();
        vm.prank(ADDRESS1);
        rule.removeAddress(ADDRESS3);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.addAddress(ADDRESS3);
        assertTrue(rule.isAddressListed(ADDRESS3));

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.removeAddress(ADDRESS3);
        assertFalse(rule.isAddressListed(ADDRESS3));
    }

    function testOnlyOwnerCanTransferOwnership() public {
        vm.prank(ADDRESS1);
        vm.expectRevert();
        rule.transferOwnership(ADDRESS2);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.transferOwnership(ADDRESS2);
        assertEq(rule.pendingOwner(), ADDRESS2);
    }

    function testMetaTxOverridesAreReachable() public view {
        assertEq(rule.exposedMsgSender(), address(this));
        assertEq(rule.exposedContextSuffixLength(), 20);
        assertGe(rule.exposedMsgData().length, 4);
    }

    function testCannotDeployWithZeroOwner() public {
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableInvalidOwner.selector, ZERO_ADDRESS));
        new RuleSpenderWhitelistOwnable2Step(ZERO_ADDRESS, ZERO_ADDRESS);
    }
}
