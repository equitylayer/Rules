// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {HelperContract} from "../HelperContract.sol";
import {IERC165} from "OZ/utils/introspection/IERC165.sol";
import {IRule} from "RuleEngine/interfaces/IRule.sol";
import {RuleInterfaceId} from "RuleEngine/modules/library/RuleInterfaceId.sol";
import {ISanctionsList} from "src/rules/interfaces/ISanctionsList.sol";
import {RuleConditionalTransferLight} from "src/rules/operation/RuleConditionalTransferLight.sol";
import {RuleConditionalTransferLightOwnable2Step} from "src/rules/operation/RuleConditionalTransferLightOwnable2Step.sol";
import {RuleBlacklist} from "src/rules/validation/deployment/RuleBlacklist.sol";
import {RuleWhitelist} from "src/rules/validation/deployment/RuleWhitelist.sol";
import {RuleWhitelistWrapper} from "src/rules/validation/deployment/RuleWhitelistWrapper.sol";
import {RuleERC2980} from "src/rules/validation/deployment/RuleERC2980.sol";
import {RuleSanctionsList} from "src/rules/validation/deployment/RuleSanctionsList.sol";
import {RuleBlacklistOwnable2Step} from "src/rules/validation/deployment/RuleBlacklistOwnable2Step.sol";
import {RuleWhitelistOwnable2Step} from "src/rules/validation/deployment/RuleWhitelistOwnable2Step.sol";
import {RuleWhitelistWrapperOwnable2Step} from "src/rules/validation/deployment/RuleWhitelistWrapperOwnable2Step.sol";
import {RuleERC2980Ownable2Step} from "src/rules/validation/deployment/RuleERC2980Ownable2Step.sol";
import {
    RuleBlacklistHarness,
    RuleWhitelistHarness,
    RuleWhitelistWrapperHarness,
    RuleERC2980Harness,
    RuleSanctionsListHarness,
    RuleBlacklistOwnable2StepHarness,
    RuleWhitelistOwnable2StepHarness,
    RuleWhitelistWrapperOwnable2StepHarness,
    RuleERC2980Ownable2StepHarness
} from "src/mocks/harness/DeploymentCoverageHarnesses.sol";

contract DeploymentCoverageExtraTest is Test, HelperContract {
    function testDeploymentWrappersAndHooksCoverage() public {
        RuleBlacklistHarness blacklist = new RuleBlacklistHarness(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS);
        RuleWhitelistHarness whitelist = new RuleWhitelistHarness(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS, true);
        RuleWhitelistWrapperHarness wrapper = new RuleWhitelistWrapperHarness(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS, true);
        RuleERC2980Harness erc2980 = new RuleERC2980Harness(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS);
        RuleSanctionsListHarness sanctions =
            new RuleSanctionsListHarness(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS, ISanctionsList(ZERO_ADDRESS));

        RuleBlacklistOwnable2StepHarness blacklistOwnable =
            new RuleBlacklistOwnable2StepHarness(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS);
        RuleWhitelistOwnable2StepHarness whitelistOwnable =
            new RuleWhitelistOwnable2StepHarness(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS, true);
        RuleWhitelistWrapperOwnable2StepHarness wrapperOwnable =
            new RuleWhitelistWrapperOwnable2StepHarness(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS, true);
        RuleERC2980Ownable2StepHarness erc2980Ownable =
            new RuleERC2980Ownable2StepHarness(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS);

        assertGe(blacklist.exposedMsgDataLength(), 4);
        assertGe(whitelist.exposedMsgDataLength(), 4);
        assertGe(wrapper.exposedMsgDataLength(), 4);
        assertGe(erc2980.exposedMsgDataLength(), 4);
        assertGe(sanctions.exposedMsgDataLength(), 4);
        assertGe(blacklistOwnable.exposedMsgDataLength(), 4);
        assertGe(whitelistOwnable.exposedMsgDataLength(), 4);
        assertGe(wrapperOwnable.exposedMsgDataLength(), 4);
        assertGe(erc2980Ownable.exposedMsgDataLength(), 4);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        blacklist.addAddress(ADDRESS1);
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        blacklist.removeAddress(ADDRESS1);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        whitelist.setCheckSpender(false);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        wrapper.setCheckSpender(false);

        bytes32 rulesManagerRole = wrapper.RULES_MANAGEMENT_ROLE();
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        wrapper.grantRole(rulesManagerRole, ADDRESS1);
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        wrapper.revokeRole(rulesManagerRole, ADDRESS1);

        assertFalse(blacklist.supportsInterface(bytes4(0xdeadbeef)));
        assertFalse(whitelist.supportsInterface(bytes4(0xdeadbeef)));
        assertFalse(wrapper.supportsInterface(bytes4(0xdeadbeef)));
        assertFalse(erc2980.supportsInterface(bytes4(0xdeadbeef)));
        assertFalse(sanctions.supportsInterface(bytes4(0xdeadbeef)));
    }
}

contract OperationCoverageExtraTest is Test, HelperContract {
    function testConditionalTransferLightCreatedDestroyedAndInterfaces() public {
        RuleConditionalTransferLight rule = new RuleConditionalTransferLight(DEFAULT_ADMIN_ADDRESS);

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        rule.bindToken(address(this));

        rule.created(ADDRESS1, 1);
        rule.destroyed(ADDRESS1, 1);

        assertTrue(rule.supportsInterface(type(IRule).interfaceId));
        assertTrue(rule.supportsInterface(RuleInterfaceId.IRULE_INTERFACE_ID));
        assertFalse(rule.supportsInterface(bytes4(0xdeadbeef)));
    }

    function testConditionalTransferLightOwnableViewAndOverloads() public {
        RuleConditionalTransferLightOwnable2Step rule =
            new RuleConditionalTransferLightOwnable2Step(CONDITIONAL_TRANSFER_OPERATOR_ADDRESS);

        vm.prank(CONDITIONAL_TRANSFER_OPERATOR_ADDRESS);
        rule.approveTransfer(ADDRESS1, ADDRESS2, 77);

        vm.prank(CONDITIONAL_TRANSFER_OPERATOR_ADDRESS);
        rule.transferred(ADDRESS3, ADDRESS1, ADDRESS2, 77);

        assertEq(rule.approvedCount(ADDRESS1, ADDRESS2, 77), 0);
        assertEq(rule.detectTransferRestrictionFrom(ADDRESS3, ADDRESS1, ADDRESS2, 77), CODE_TRANSFER_REQUEST_NOT_APPROVED);
        assertFalse(rule.canTransfer(ADDRESS1, ADDRESS2, 77));
        assertFalse(rule.canTransferFrom(ADDRESS3, ADDRESS1, ADDRESS2, 77));
        assertTrue(rule.canReturnTransferRestrictionCode(CODE_TRANSFER_REQUEST_NOT_APPROVED));
        assertEq(rule.messageForTransferRestriction(CODE_TRANSFER_REQUEST_NOT_APPROVED), TEXT_TRANSFER_REQUEST_NOT_APPROVED);
        assertEq(rule.messageForTransferRestriction(CODE_NONEXISTENT), TEXT_CODE_NOT_FOUND);

        assertTrue(rule.supportsInterface(type(IERC165).interfaceId));
        assertTrue(rule.supportsInterface(type(IRule).interfaceId));
        assertTrue(rule.supportsInterface(RuleInterfaceId.IRULE_INTERFACE_ID));
        assertFalse(rule.supportsInterface(bytes4(0xdeadbeef)));
    }
}
