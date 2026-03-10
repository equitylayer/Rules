**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [arbitrary-send-erc20](#arbitrary-send-erc20) (1 results) (High)
 - [unused-return](#unused-return) (6 results) (Medium)
 - [calls-loop](#calls-loop) (16 results) (Low)
 - [assembly](#assembly) (1 results) (Informational)
 - [missing-inheritance](#missing-inheritance) (1 results) (Informational)
 - [naming-convention](#naming-convention) (2 results) (Informational)
 - [unindexed-event-address](#unindexed-event-address) (2 results) (Informational)
 - [unused-state](#unused-state) (60 results) (Informational)
## arbitrary-send-erc20
Impact: High
Confidence: High
 - [ ] ID-0
[RuleConditionalTransferLightBase.approveAndTransferIfAllowed(address,address,address,uint256)](src/rules/operation/abstract/RuleConditionalTransferLightBase.sol#L47-L62) uses arbitrary from in transferFrom: [success = IERC20(token).transferFrom(from,to,value)](src/rules/operation/abstract/RuleConditionalTransferLightBase.sol#L59)

src/rules/operation/abstract/RuleConditionalTransferLightBase.sol#L47-L62


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-1
[RuleAddressSetInternal._removeAddress(address)](src/rules/validation/abstract/RuleAddressSet/RuleAddressSetInternal.sol#L82-L84) ignores return value by [_listedAddresses.remove(targetAddress)](src/rules/validation/abstract/RuleAddressSet/RuleAddressSetInternal.sol#L83)

src/rules/validation/abstract/RuleAddressSet/RuleAddressSetInternal.sol#L82-L84


 - [ ] ID-2
[RuleERC2980Internal._addWhitelistAddress(address)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L59-L61) ignores return value by [_whitelist.add(targetAddress)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L60)

src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L59-L61


 - [ ] ID-3
[RuleAddressSetInternal._addAddress(address)](src/rules/validation/abstract/RuleAddressSet/RuleAddressSetInternal.sol#L74-L76) ignores return value by [_listedAddresses.add(targetAddress)](src/rules/validation/abstract/RuleAddressSet/RuleAddressSetInternal.sol#L75)

src/rules/validation/abstract/RuleAddressSet/RuleAddressSetInternal.sol#L74-L76


 - [ ] ID-4
[RuleERC2980Internal._removeWhitelistAddress(address)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L63-L65) ignores return value by [_whitelist.remove(targetAddress)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L64)

src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L63-L65


 - [ ] ID-5
[RuleERC2980Internal._addFrozenlistAddress(address)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L105-L107) ignores return value by [_frozenlist.add(targetAddress)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L106)

src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L105-L107


 - [ ] ID-6
[RuleERC2980Internal._removeFrozenlistAddress(address)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L109-L111) ignores return value by [_frozenlist.remove(targetAddress)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L110)

src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L109-L111


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-7
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleNFTAdapter.detectTransferRestriction(address,address,uint256,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-8
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleTransferValidation.detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-9
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleWhitelistShared.transferred(address,address,uint256)
		RuleWhitelistWrapperBase._transferred(address,address,uint256)
		RuleWhitelistShared._transferred(address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-10
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleTransferValidation.canTransfer(address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-11
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleNFTAdapter.transferred(address,address,uint256,uint256)
		RuleWhitelistWrapperBase._transferred(address,address,uint256)
		RuleWhitelistShared._transferred(address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-12
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleTransferValidation.detectTransferRestriction(address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-13
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleNFTAdapter.transferred(ITransferContext.MultiTokenTransferContext)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-14
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleWhitelistWrapperBase.isVerified(address)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-15
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleNFTAdapter.canTransfer(address,address,uint256,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-16
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleNFTAdapter.transferred(address,address,address,uint256,uint256)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-17
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleNFTAdapter.detectTransferRestrictionFrom(address,address,address,uint256,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-18
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleNFTAdapter.canTransferFrom(address,address,address,uint256,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-19
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleNFTAdapter.transferred(ITransferContext.FungibleTransferContext)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-20
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleWhitelistShared.transferred(address,address,address,uint256)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-21
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleWhitelistWrapperHarnessInternal.exposedTransferredSpenderInternal(address,address,address,uint256)
		RuleWhitelistWrapperBase._transferred(address,address,address,uint256)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


 - [ ] ID-22
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L176)
	Calls stack containing the loop:
		RuleTransferValidation.canTransferFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L165-L196


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-23
[RuleConditionalTransferLightBase._transferHash(address,address,uint256)](src/rules/operation/abstract/RuleConditionalTransferLightBase.sol#L178-L187) uses assembly
	- [INLINE ASM](src/rules/operation/abstract/RuleConditionalTransferLightBase.sol#L180-L186)

src/rules/operation/abstract/RuleConditionalTransferLightBase.sol#L178-L187


## missing-inheritance
Impact: Informational
Confidence: High
 - [ ] ID-24
[TotalSupplyMock](src/mocks/TotalSupplyMock.sol#L4-L14) should inherit from [ITotalSupply](src/rules/interfaces/ITotalSupply.sol#L4-L6)

src/mocks/TotalSupplyMock.sol#L4-L14


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-25
Parameter [RuleERC2980Base.frozenlist(address)._operator](src/rules/validation/abstract/base/RuleERC2980Base.sol#L314) is not in mixedCase

src/rules/validation/abstract/base/RuleERC2980Base.sol#L314


 - [ ] ID-26
Parameter [RuleERC2980Base.whitelist(address)._operator](src/rules/validation/abstract/base/RuleERC2980Base.sol#L224) is not in mixedCase

src/rules/validation/abstract/base/RuleERC2980Base.sol#L224


## unindexed-event-address
Impact: Informational
Confidence: High
 - [ ] ID-27
Event [IERC3643Compliance.TokenBound(address)](lib/RuleEngine/src/interfaces/IERC3643Compliance.sol#L14) has address parameters but no indexed parameters

lib/RuleEngine/src/interfaces/IERC3643Compliance.sol#L14


 - [ ] ID-28
Event [IERC3643Compliance.TokenUnbound(address)](lib/RuleEngine/src/interfaces/IERC3643Compliance.sol#L20) has address parameters but no indexed parameters

lib/RuleEngine/src/interfaces/IERC3643Compliance.sol#L20


## unused-state
Impact: Informational
Confidence: High
 - [ ] ID-29
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleERC2980Ownable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L89-L95)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-30
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleWhitelistOwnable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L69-L77)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-31
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleBlacklistHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L15-L21)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-32
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleERC2980Ownable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L89-L95)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-33
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleWhitelistWrapperHarnessInternal](src/mocks/harness/RuleWhitelistWrapperHarnessInternal.sol#L6-L14)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-34
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleWhitelistHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L23-L31)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-35
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleSanctionsListHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L51-L59)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-36
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleSanctionsListOwnable2StepHarness](src/mocks/harness/RuleSanctionsListOwnable2StepHarness.sol#L7-L23)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-37
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleERC2980Harness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L43-L49)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-38
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleERC2980Harness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L43-L49)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-39
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleWhitelistWrapperOwnable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L79-L87)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-40
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleWhitelistWrapperHarnessInternal](src/mocks/harness/RuleWhitelistWrapperHarnessInternal.sol#L6-L14)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-41
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleBlacklistHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L15-L21)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-42
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleWhitelistWrapperHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L33-L41)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-43
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleIdentityRegistryOwnable2Step](src/rules/validation/deployment/RuleIdentityRegistryOwnable2Step.sol#L12-L16)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-44
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleERC2980Ownable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L89-L95)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-45
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleBlacklistOwnable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L61-L67)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-46
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleBlacklistOwnable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L61-L67)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-47
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleWhitelistWrapperHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L33-L41)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-48
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleERC2980Ownable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L89-L95)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-49
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleERC2980Harness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L43-L49)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-50
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleSpenderWhitelistHarness](src/mocks/harness/RuleSpenderWhitelistHarnesses.sol#L7-L21)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-51
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleWhitelistWrapperOwnable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L79-L87)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-52
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleIdentityRegistryOwnable2Step](src/rules/validation/deployment/RuleIdentityRegistryOwnable2Step.sol#L12-L16)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-53
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleSpenderWhitelistOwnable2StepHarness](src/mocks/harness/RuleSpenderWhitelistHarnesses.sol#L23-L39)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-54
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleWhitelistWrapperHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L33-L41)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-55
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleIdentityRegistryOwnable2Step](src/rules/validation/deployment/RuleIdentityRegistryOwnable2Step.sol#L12-L16)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-56
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleWhitelistOwnable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L69-L77)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-57
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleIdentityRegistryOwnable2Step](src/rules/validation/deployment/RuleIdentityRegistryOwnable2Step.sol#L12-L16)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-58
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleIdentityRegistry](src/rules/validation/deployment/RuleIdentityRegistry.sol#L14-L36)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-59
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleWhitelistWrapperHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L33-L41)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-60
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleERC2980Harness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L43-L49)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-61
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleBlacklistHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L15-L21)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-62
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleWhitelistWrapperHarnessInternal](src/mocks/harness/RuleWhitelistWrapperHarnessInternal.sol#L6-L14)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-63
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleBlacklistHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L15-L21)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-64
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleWhitelistWrapperOwnable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L79-L87)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-65
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleWhitelistHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L23-L31)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-66
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleSpenderWhitelistHarness](src/mocks/harness/RuleSpenderWhitelistHarnesses.sol#L7-L21)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-67
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleWhitelistHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L23-L31)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-68
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleSpenderWhitelistHarness](src/mocks/harness/RuleSpenderWhitelistHarnesses.sol#L7-L21)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-69
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleIdentityRegistry](src/rules/validation/deployment/RuleIdentityRegistry.sol#L14-L36)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-70
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleBlacklistOwnable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L61-L67)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-71
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleWhitelistWrapperOwnable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L79-L87)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-72
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleWhitelistWrapperHarnessInternal](src/mocks/harness/RuleWhitelistWrapperHarnessInternal.sol#L6-L14)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-73
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleIdentityRegistry](src/rules/validation/deployment/RuleIdentityRegistry.sol#L14-L36)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-74
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleSpenderWhitelistOwnable2StepHarness](src/mocks/harness/RuleSpenderWhitelistHarnesses.sol#L23-L39)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-75
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleSanctionsListHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L51-L59)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-76
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleWhitelistHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L23-L31)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-77
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleWhitelistOwnable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L69-L77)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-78
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleSanctionsListOwnable2StepHarness](src/mocks/harness/RuleSanctionsListOwnable2StepHarness.sol#L7-L23)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-79
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleSpenderWhitelistOwnable2StepHarness](src/mocks/harness/RuleSpenderWhitelistHarnesses.sol#L23-L39)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-80
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleSanctionsListOwnable2StepHarness](src/mocks/harness/RuleSanctionsListOwnable2StepHarness.sol#L7-L23)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-81
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleSpenderWhitelistOwnable2StepHarness](src/mocks/harness/RuleSpenderWhitelistHarnesses.sol#L23-L39)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-82
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleSanctionsListHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L51-L59)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-83
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleSpenderWhitelistHarness](src/mocks/harness/RuleSpenderWhitelistHarnesses.sol#L7-L21)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-84
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleSanctionsListOwnable2StepHarness](src/mocks/harness/RuleSanctionsListOwnable2StepHarness.sol#L7-L23)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-85
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleIdentityRegistry](src/rules/validation/deployment/RuleIdentityRegistry.sol#L14-L36)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-86
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleBlacklistOwnable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L61-L67)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-87
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleSanctionsListHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L51-L59)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-88
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleWhitelistOwnable2StepHarness](src/mocks/harness/DeploymentCoverageHarnesses.sol#L69-L77)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


