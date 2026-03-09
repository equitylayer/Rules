**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [arbitrary-send-erc20](#arbitrary-send-erc20) (1 results) (High)
 - [unused-return](#unused-return) (6 results) (Medium)
 - [calls-loop](#calls-loop) (15 results) (Low)
 - [dead-code](#dead-code) (14 results) (Informational)
 - [naming-convention](#naming-convention) (2 results) (Informational)
 - [unindexed-event-address](#unindexed-event-address) (2 results) (Informational)
 - [unused-state](#unused-state) (48 results) (Informational)
## arbitrary-send-erc20
Impact: High
Confidence: High
 - [ ] ID-0
[RuleConditionalTransferLightBase.approveAndTransferIfAllowed(address,address,address,uint256)](src/rules/operation/abstract/RuleConditionalTransferLightBase.sol#L44-L62) uses arbitrary from in transferFrom: [success = IERC20(token).transferFrom(from,to,value)](src/rules/operation/abstract/RuleConditionalTransferLightBase.sol#L59)

src/rules/operation/abstract/RuleConditionalTransferLightBase.sol#L44-L62


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-1
[RuleAddressSetInternal._removeAddress(address)](src/rules/validation/abstract/RuleAddressSet/RuleAddressSetInternal.sol#L85-L87) ignores return value by [_listedAddresses.remove(targetAddress)](src/rules/validation/abstract/RuleAddressSet/RuleAddressSetInternal.sol#L86)

src/rules/validation/abstract/RuleAddressSet/RuleAddressSetInternal.sol#L85-L87


 - [ ] ID-2
[RuleERC2980Internal._addWhitelistAddress(address)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L59-L61) ignores return value by [_whitelist.add(targetAddress)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L60)

src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L59-L61


 - [ ] ID-3
[RuleERC2980Internal._removeWhitelistAddress(address)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L63-L65) ignores return value by [_whitelist.remove(targetAddress)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L64)

src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L63-L65


 - [ ] ID-4
[RuleERC2980Internal._addFrozenlistAddress(address)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L105-L107) ignores return value by [_frozenlist.add(targetAddress)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L106)

src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L105-L107


 - [ ] ID-5
[RuleERC2980Internal._removeFrozenlistAddress(address)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L109-L111) ignores return value by [_frozenlist.remove(targetAddress)](src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L110)

src/rules/validation/abstract/RuleERC2980/RuleERC2980Internal.sol#L109-L111


 - [ ] ID-6
[RuleAddressSetInternal._addAddress(address)](src/rules/validation/abstract/RuleAddressSet/RuleAddressSetInternal.sol#L77-L79) ignores return value by [_listedAddresses.add(targetAddress)](src/rules/validation/abstract/RuleAddressSet/RuleAddressSetInternal.sol#L78)

src/rules/validation/abstract/RuleAddressSet/RuleAddressSetInternal.sol#L77-L79


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-7
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleNFTAdapter.transferred(ITransferContext.FungibleTransferContext)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-8
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleTransferValidation.detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-9
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleWhitelistShared.transferred(address,address,uint256)
		RuleWhitelistWrapperBase._transferred(address,address,uint256)
		RuleWhitelistShared._transferred(address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-10
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleTransferValidation.canTransferFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-11
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleWhitelistShared.transferred(address,address,address,uint256)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-12
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleTransferValidation.detectTransferRestriction(address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-13
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleNFTAdapter.canTransferFrom(address,address,address,uint256,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-14
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleNFTAdapter.transferred(ITransferContext.MultiTokenTransferContext)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-15
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleTransferValidation.canTransfer(address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-16
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleWhitelistWrapperBase.isVerified(address)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-17
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleNFTAdapter.detectTransferRestriction(address,address,uint256,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-18
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleNFTAdapter.detectTransferRestrictionFrom(address,address,address,uint256,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-19
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleNFTAdapter.canTransfer(address,address,uint256,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-20
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleNFTAdapter.transferred(address,address,address,uint256,uint256)
		RuleWhitelistShared._transferredFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestrictionFrom(address,address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


 - [ ] ID-21
[RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(address[])](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202) has external calls inside a loop: [isListed = IAddressList(rule(i)).areAddressesListed(targetAddress)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L182)
	Calls stack containing the loop:
		RuleNFTAdapter.transferred(address,address,uint256,uint256)
		RuleWhitelistWrapperBase._transferred(address,address,uint256)
		RuleWhitelistShared._transferred(address,address,uint256)
		RuleWhitelistWrapperBase._detectTransferRestriction(address,address,uint256)

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L171-L202


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-22
[RuleAddressSet._msgData()](src/rules/validation/abstract/RuleAddressSet/RuleAddressSet.sol#L159-L161) is never used and should be removed

src/rules/validation/abstract/RuleAddressSet/RuleAddressSet.sol#L159-L161


 - [ ] ID-23
[RuleBlacklistOwnable2Step._msgData()](src/rules/validation/deployment/RuleBlacklistOwnable2Step.sol#L28-L30) is never used and should be removed

src/rules/validation/deployment/RuleBlacklistOwnable2Step.sol#L28-L30


 - [ ] ID-24
[RuleERC2980._msgData()](src/rules/validation/deployment/RuleERC2980.sol#L76-L78) is never used and should be removed

src/rules/validation/deployment/RuleERC2980.sol#L76-L78


 - [ ] ID-25
[RuleWhitelistWrapperBase._msgData()](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L237-L239) is never used and should be removed

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L237-L239


 - [ ] ID-26
[RuleERC2980Base._msgData()](src/rules/validation/abstract/base/RuleERC2980Base.sol#L381-L383) is never used and should be removed

src/rules/validation/abstract/base/RuleERC2980Base.sol#L381-L383


 - [ ] ID-27
[RuleWhitelistWrapperOwnable2Step._msgData()](src/rules/validation/deployment/RuleWhitelistWrapperOwnable2Step.sol#L43-L45) is never used and should be removed

src/rules/validation/deployment/RuleWhitelistWrapperOwnable2Step.sol#L43-L45


 - [ ] ID-28
[RuleSanctionsListOwnable2Step._msgData()](src/rules/validation/deployment/RuleSanctionsListOwnable2Step.sol#L27-L29) is never used and should be removed

src/rules/validation/deployment/RuleSanctionsListOwnable2Step.sol#L27-L29


 - [ ] ID-29
[RuleSanctionsList._msgData()](src/rules/validation/deployment/RuleSanctionsList.sol#L51-L53) is never used and should be removed

src/rules/validation/deployment/RuleSanctionsList.sol#L51-L53


 - [ ] ID-30
[RuleWhitelistWrapper._msgData()](src/rules/validation/deployment/RuleWhitelistWrapper.sol#L62-L64) is never used and should be removed

src/rules/validation/deployment/RuleWhitelistWrapper.sol#L62-L64


 - [ ] ID-31
[RuleWhitelistWrapperBase._transferred(address,address,address,uint256)](src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L153-L160) is never used and should be removed

src/rules/validation/abstract/base/RuleWhitelistWrapperBase.sol#L153-L160


 - [ ] ID-32
[RuleBlacklist._msgData()](src/rules/validation/deployment/RuleBlacklist.sol#L46-L48) is never used and should be removed

src/rules/validation/deployment/RuleBlacklist.sol#L46-L48


 - [ ] ID-33
[RuleERC2980Ownable2Step._msgData()](src/rules/validation/deployment/RuleERC2980Ownable2Step.sol#L32-L34) is never used and should be removed

src/rules/validation/deployment/RuleERC2980Ownable2Step.sol#L32-L34


 - [ ] ID-34
[RuleWhitelist._msgData()](src/rules/validation/deployment/RuleWhitelist.sol#L66-L68) is never used and should be removed

src/rules/validation/deployment/RuleWhitelist.sol#L66-L68


 - [ ] ID-35
[RuleWhitelistOwnable2Step._msgData()](src/rules/validation/deployment/RuleWhitelistOwnable2Step.sol#L30-L32) is never used and should be removed

src/rules/validation/deployment/RuleWhitelistOwnable2Step.sol#L30-L32


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-36
Parameter [RuleERC2980Base.frozenlist(address)._operator](src/rules/validation/abstract/base/RuleERC2980Base.sol#L322) is not in mixedCase

src/rules/validation/abstract/base/RuleERC2980Base.sol#L322


 - [ ] ID-37
Parameter [RuleERC2980Base.whitelist(address)._operator](src/rules/validation/abstract/base/RuleERC2980Base.sol#L226) is not in mixedCase

src/rules/validation/abstract/base/RuleERC2980Base.sol#L226


## unindexed-event-address
Impact: Informational
Confidence: High
 - [ ] ID-38
Event [IERC3643Compliance.TokenBound(address)](lib/RuleEngine/src/interfaces/IERC3643Compliance.sol#L14) has address parameters but no indexed parameters

lib/RuleEngine/src/interfaces/IERC3643Compliance.sol#L14


 - [ ] ID-39
Event [IERC3643Compliance.TokenUnbound(address)](lib/RuleEngine/src/interfaces/IERC3643Compliance.sol#L20) has address parameters but no indexed parameters

lib/RuleEngine/src/interfaces/IERC3643Compliance.sol#L20


## unused-state
Impact: Informational
Confidence: High
 - [ ] ID-40
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27) is never used in [RuleERC2980Ownable2Step](src/rules/validation/deployment/RuleERC2980Ownable2Step.sol#L14-L39)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27


 - [ ] ID-41
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleWhitelistWrapper](src/rules/validation/deployment/RuleWhitelistWrapper.sol#L16-L98)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-42
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27) is never used in [RuleSanctionsList](src/rules/validation/deployment/RuleSanctionsList.sol#L16-L58)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27


 - [ ] ID-43
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleSanctionsListOwnable2Step](src/rules/validation/deployment/RuleSanctionsListOwnable2Step.sol#L15-L34)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-44
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27) is never used in [RuleWhitelistWrapperOwnable2Step](src/rules/validation/deployment/RuleWhitelistWrapperOwnable2Step.sol#L15-L51)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27


 - [ ] ID-45
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleIdentityRegistryOwnable2Step](src/rules/validation/deployment/RuleIdentityRegistryOwnable2Step.sol#L12-L16)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-46
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21) is never used in [RuleBlacklistOwnable2Step](src/rules/validation/deployment/RuleBlacklistOwnable2Step.sol#L14-L35)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21


 - [ ] ID-47
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleWhitelistWrapper](src/rules/validation/deployment/RuleWhitelistWrapper.sol#L16-L98)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-48
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleSanctionsList](src/rules/validation/deployment/RuleSanctionsList.sol#L16-L58)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-49
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27) is never used in [RuleWhitelist](src/rules/validation/deployment/RuleWhitelist.sol#L20-L73)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27


 - [ ] ID-50
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21) is never used in [RuleERC2980](src/rules/validation/deployment/RuleERC2980.sol#L32-L83)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21


 - [ ] ID-51
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27) is never used in [RuleSanctionsListOwnable2Step](src/rules/validation/deployment/RuleSanctionsListOwnable2Step.sol#L15-L34)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27


 - [ ] ID-52
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleIdentityRegistryOwnable2Step](src/rules/validation/deployment/RuleIdentityRegistryOwnable2Step.sol#L12-L16)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-53
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27) is never used in [RuleWhitelistWrapper](src/rules/validation/deployment/RuleWhitelistWrapper.sol#L16-L98)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27


 - [ ] ID-54
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27) is never used in [RuleERC2980](src/rules/validation/deployment/RuleERC2980.sol#L32-L83)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27


 - [ ] ID-55
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27) is never used in [RuleIdentityRegistryOwnable2Step](src/rules/validation/deployment/RuleIdentityRegistryOwnable2Step.sol#L12-L16)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27


 - [ ] ID-56
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21) is never used in [RuleIdentityRegistryOwnable2Step](src/rules/validation/deployment/RuleIdentityRegistryOwnable2Step.sol#L12-L16)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21


 - [ ] ID-57
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleIdentityRegistry](src/rules/validation/deployment/RuleIdentityRegistry.sol#L14-L36)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-58
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27) is never used in [RuleBlacklistOwnable2Step](src/rules/validation/deployment/RuleBlacklistOwnable2Step.sol#L14-L35)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27


 - [ ] ID-59
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleWhitelistWrapperOwnable2Step](src/rules/validation/deployment/RuleWhitelistWrapperOwnable2Step.sol#L15-L51)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-60
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleWhitelist](src/rules/validation/deployment/RuleWhitelist.sol#L20-L73)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-61
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleSanctionsList](src/rules/validation/deployment/RuleSanctionsList.sol#L16-L58)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-62
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleERC2980Ownable2Step](src/rules/validation/deployment/RuleERC2980Ownable2Step.sol#L14-L39)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-63
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21) is never used in [RuleERC2980Ownable2Step](src/rules/validation/deployment/RuleERC2980Ownable2Step.sol#L14-L39)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21


 - [ ] ID-64
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleBlacklistOwnable2Step](src/rules/validation/deployment/RuleBlacklistOwnable2Step.sol#L14-L35)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-65
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21) is never used in [RuleSanctionsList](src/rules/validation/deployment/RuleSanctionsList.sol#L16-L58)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21


 - [ ] ID-66
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleSanctionsListOwnable2Step](src/rules/validation/deployment/RuleSanctionsListOwnable2Step.sol#L15-L34)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-67
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleERC2980](src/rules/validation/deployment/RuleERC2980.sol#L32-L83)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-68
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleWhitelist](src/rules/validation/deployment/RuleWhitelist.sol#L20-L73)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-69
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleIdentityRegistry](src/rules/validation/deployment/RuleIdentityRegistry.sol#L14-L36)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-70
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21) is never used in [RuleWhitelist](src/rules/validation/deployment/RuleWhitelist.sol#L20-L73)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21


 - [ ] ID-71
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21) is never used in [RuleSanctionsListOwnable2Step](src/rules/validation/deployment/RuleSanctionsListOwnable2Step.sol#L15-L34)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21


 - [ ] ID-72
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleBlacklist](src/rules/validation/deployment/RuleBlacklist.sol#L15-L53)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-73
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleWhitelistOwnable2Step](src/rules/validation/deployment/RuleWhitelistOwnable2Step.sol#L14-L37)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-74
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27) is never used in [RuleIdentityRegistry](src/rules/validation/deployment/RuleIdentityRegistry.sol#L14-L36)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27


 - [ ] ID-75
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleWhitelistOwnable2Step](src/rules/validation/deployment/RuleWhitelistOwnable2Step.sol#L14-L37)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-76
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27) is never used in [RuleWhitelistOwnable2Step](src/rules/validation/deployment/RuleWhitelistOwnable2Step.sol#L14-L37)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27


 - [ ] ID-77
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21) is never used in [RuleWhitelistOwnable2Step](src/rules/validation/deployment/RuleWhitelistOwnable2Step.sol#L14-L37)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21


 - [ ] ID-78
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleBlacklistOwnable2Step](src/rules/validation/deployment/RuleBlacklistOwnable2Step.sol#L14-L35)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-79
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943_FROM](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27) is never used in [RuleBlacklist](src/rules/validation/deployment/RuleBlacklist.sol#L15-L53)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L26-L27


 - [ ] ID-80
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleERC2980](src/rules/validation/deployment/RuleERC2980.sol#L32-L83)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-81
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21) is never used in [RuleBlacklist](src/rules/validation/deployment/RuleBlacklist.sol#L15-L53)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21


 - [ ] ID-82
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21) is never used in [RuleWhitelistWrapperOwnable2Step](src/rules/validation/deployment/RuleWhitelistWrapperOwnable2Step.sol#L15-L51)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21


 - [ ] ID-83
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21) is never used in [RuleIdentityRegistry](src/rules/validation/deployment/RuleIdentityRegistry.sol#L14-L36)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21


 - [ ] ID-84
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC3643](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21) is never used in [RuleWhitelistWrapper](src/rules/validation/deployment/RuleWhitelistWrapper.sol#L16-L98)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L20-L21


 - [ ] ID-85
[RuleNFTAdapter.TRANSFERRED_SELECTOR_ERC7943](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25) is never used in [RuleBlacklist](src/rules/validation/deployment/RuleBlacklist.sol#L15-L53)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L24-L25


 - [ ] ID-86
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleERC2980Ownable2Step](src/rules/validation/deployment/RuleERC2980Ownable2Step.sol#L14-L39)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


 - [ ] ID-87
[RuleNFTAdapter.TRANSFERRED_SELECTOR_RULE_ENGINE](src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23) is never used in [RuleWhitelistWrapperOwnable2Step](src/rules/validation/deployment/RuleWhitelistWrapperOwnable2Step.sol#L15-L51)

src/rules/validation/abstract/core/RuleNFTAdapter.sol#L22-L23


