# Gas Benchmarks

This file tracks gas usage for key rule operations. Update it after running:

```bash
forge snapshot
```

## Benchmarks (forge snapshot, 2026-03-04)

- `RuleWhitelist.addAddress` (`RuleWhitelistAddTest:testaddAddress`) — `130,153` gas
- `RuleWhitelist.addAddresses` (`RuleWhitelistAddTest:testaddAddresses`) — `185,477` gas
- `RuleWhitelist.removeAddress` (`RuleWhitelistRemoveTest:testRemoveAddress`) — `86,109` gas
- `RuleWhitelist.removeAddresses` (`RuleWhitelistRemoveTest:testRemoveAddressWhenArrayContainSeveralAddresses`) — `131,305` gas
- `RuleWhitelistWrapper.detectTransferRestriction` with 3 sub-rules (`CMTATIntegrationWhitelistWrapper:testDetectTransferRestrictionOk`) — `175,185` gas
- `RuleSanctionsList.detectTransferRestriction` (`RuleSanctionlistTest:testDetectTransferRestrictionOk`) — `30,013` gas
- `RuleConditionalTransferLight.approveTransfer` (`RuleConditionalTransferLightUnit:testApproveTransfer_OnlyOperator`) — `41,763` gas
- `RuleConditionalTransferLight.transferred` (`RuleConditionalTransferLightUnit:testTransferred_OnlyRuleEngineRole`) — `33,214` gas

Add new entries when behavior changes or additional rules are added.
