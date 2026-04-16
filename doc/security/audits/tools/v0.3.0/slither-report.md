**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [arbitrary-send-erc20](#arbitrary-send-erc20) (1 results) (High)
 - [unused-return](#unused-return) (6 results) (Medium)
 - [calls-loop](#calls-loop) (16 results) (Low)
 - [assembly](#assembly) (1 results) (Informational)
 - [naming-convention](#naming-convention) (2 results) (Informational)
 - [unindexed-event-address](#unindexed-event-address) (2 results) (Informational)
 - [unused-state](#unused-state) (8 results) (Informational)
## arbitrary-send-erc20
Impact: High
Confidence: High
 - [ ] ID-0
[RuleConditionalTransferLightBase.approveAndTransferIfAllowed(address,address,uint256)](src/rules/operation/abstract/RuleConditionalTransferLightBase.sol#L66-L81) uses arbitrary from in transferFrom: [IERC20(token).safeTransferFrom(from,to,value)](src/rules/operation/abstract/RuleConditionalTransferLightBase.sol#L79)

src/rules/operation/abstract/RuleConditionalTransferLightBase.sol#L66-L81


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
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleTransferValidation.canTransfer(address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-8
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleWhitelistShared.transferred(address,address,address,uint256)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-9
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleWhitelistWrapperBase.isVerified(address)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-10
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleTransferValidation.detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-11
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleNFTAdapter.transferred(ITransferContext.MultiTokenTransferContext)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-12
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleWhitelistShared.transferred(address,address,uint256)
		RuleWhitelistWrapperBase._transferred(address,address,uint256)
		RuleWhitelistShared._transferred(address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-13
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleNFTAdapter.canTransferFrom(address,address,address,uint256,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-14
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleTransferValidation.detectTransferRestriction(address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-15
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleNFTAdapter.transferred(ITransferContext.FungibleTransferContext)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-16
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleNFTAdapter.transferred(address,address,uint256,uint256)
		RuleWhitelistWrapperBase._transferred(address,address,uint256)
		RuleWhitelistShared._transferred(address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-17
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleWhitelistWrapperHarnessInternal.exposedTransferredSpenderInternal(address,address,address,uint256)
		RuleWhitelistWrapperBase._transferred(address,address,address,uint256)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-18
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleNFTAdapter.detectTransferRestriction(address,address,uint256,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-19
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleNFTAdapter.transferred(address,address,address,uint256,uint256)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-20
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleNFTAdapter.canTransfer(address,address,uint256,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-21
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleTransferValidation.canTransferFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


 - [ ] ID-22
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L185)
	Calls stack containing the loop:
		RuleNFTAdapter.detectTransferRestrictionFrom(address,address,address,uint256,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L174-L205


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-23
[RuleConditionalTransferLightApprovalBase._transferHash(address,address,uint256)](src/rules/operation/abstract/RuleConditionalTransferLightApprovalBase.sol#L86-L95) uses assembly
	- [INLINE ASM](src/rules/operation/abstract/RuleConditionalTransferLightApprovalBase.sol#L88-L94)

src/rules/operation/abstract/RuleConditionalTransferLightApprovalBase.sol#L86-L95


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-24
Parameter [RuleERC2980Base.frozenlist(address)._operator](src/rules/validation/abstract/base/RuleERC2980Base.sol#L291) is not in mixedCase

src/rules/validation/abstract/base/RuleERC2980Base.sol#L291


 - [ ] ID-25
Parameter [RuleERC2980Base.whitelist(address)._operator](src/rules/validation/abstract/base/RuleERC2980Base.sol#L251) is not in mixedCase

src/rules/validation/abstract/base/RuleERC2980Base.sol#L251


## unindexed-event-address
Impact: Informational
Confidence: High
 - [ ] ID-26
Event [IERC3643Compliance.TokenBound(address)](lib/RuleEngine/src/interfaces/IERC3643Compliance.sol#L14) has address parameters but no indexed parameters

lib/RuleEngine/src/interfaces/IERC3643Compliance.sol#L14


 - [ ] ID-27
Event [IERC3643Compliance.TokenUnbound(address)](lib/RuleEngine/src/interfaces/IERC3643Compliance.sol#L20) has address parameters but no indexed parameters

lib/RuleEngine/src/interfaces/IERC3643Compliance.sol#L20


## unused-state
Impact: Informational
Confidence: High
 - [ ] ID-28
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleIdentityRegistryOwnable2Step](src/rules/validation/deployment/RuleIdentityRegistryOwnable2Step.sol#L12-L24)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-29
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleIdentityRegistryOwnable2Step](src/rules/validation/deployment/RuleIdentityRegistryOwnable2Step.sol#L12-L24)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-30
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleIdentityRegistryOwnable2Step](src/rules/validation/deployment/RuleIdentityRegistryOwnable2Step.sol#L12-L24)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-31
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleIdentityRegistryOwnable2Step](src/rules/validation/deployment/RuleIdentityRegistryOwnable2Step.sol#L12-L24)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


 - [ ] ID-32
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleIdentityRegistry](src/rules/validation/deployment/RuleIdentityRegistry.sol#L14-L44)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-33
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21) is never used in [RuleIdentityRegistry](src/rules/validation/deployment/RuleIdentityRegistry.sol#L14-L44)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L21


 - [ ] ID-34
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleIdentityRegistry](src/rules/validation/deployment/RuleIdentityRegistry.sol#L14-L44)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-35
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20) is never used in [RuleIdentityRegistry](src/rules/validation/deployment/RuleIdentityRegistry.sol#L14-L44)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20


