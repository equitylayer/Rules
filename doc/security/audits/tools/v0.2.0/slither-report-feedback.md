# Slither Report — Feedback

Report version: `v0.2.0`
Slither report: [slither-report.md](./slither-report.md)
Feedback date: 2026-03-10

Verdicts:

| Verdict | Meaning |
|---|---|
| **Acknowledged** | Known, accepted by design; no change planned. |
| **Acknowledged — low impact** | Technically valid but actual risk is negligible given context. |
| **Fixed** | Resolved in the codebase. |
| **False positive** | Tool mis-identification; no real issue exists. |

---

## arbitrary-send-erc20 (High) — ID-0

**Verdict: False positive**

Flagged: `approveAndTransferIfAllowed` uses `IERC20(token).transferFrom(from, to, value)` where `from` is a parameter.

The concern for "arbitrary from" is that a malicious caller could drain any address. This does not apply here for three reasons:

1. The function is gated by `onlyTransferApprover` — only an authorised operator or owner can call it.
2. `from` must have granted an ERC-20 allowance to this contract beforehand (`allowance(from, address(this)) >= value` is checked).
3. `approveTransfer(from, to, value)` is called first, which records a pre-approved transfer entry (CEI is intentionally inverted, as documented in the NatSpec: *"CEI is intentionally inverted so the approval exists for the callback"*).

An unauthorised caller cannot reach `transferFrom`, and an authorised caller can only transfer from an address that has explicitly approved the contract. The pattern is intentional and safe.

---

## unused-return (Medium) — ID-1 to ID-6

**Verdict: False positive**

All six instances point to `EnumerableSet.add` / `.remove` calls inside the single-item internal helpers (`_addAddress`, `_removeAddress`, `_addWhitelistAddress`, etc.) whose boolean return is not captured.

The public-facing callers perform an explicit existence check **before** calling the helper:

```solidity
// RuleAddressSet.addAddress
require(!_isAddressListed(targetAddress), RuleAddressSet_AddressAlreadyListed());
_addAddress(targetAddress); // guaranteed to succeed at this point

// RuleAddressSet.removeAddress
require(_isAddressListed(targetAddress), RuleAddressSet_AddressNotFound());
_removeAddress(targetAddress); // guaranteed to succeed at this point
```

The same pattern is used in `RuleERC2980Base` for whitelist and frozenlist single-item operations. Because the pre-check guarantees the set operation will succeed, ignoring the return value of `.add` / `.remove` is safe. No change needed.

---

## calls-loop (Low) — ID-7 to ID-22

**Verdict: Acknowledged — by design**

All 16 instances trace to the same root location: `RuleWhitelistWrapperBase._detectTransferRestrictionForTargets` iterates over child rules and calls `IAddressList(rule(i)).areAddressesListed(...)` for each.

This is the fundamental purpose of the wrapper: aggregate multiple whitelist rules with OR logic. There is no way to avoid external calls per child rule. Mitigations already in place:

- The list of child rules is bounded and managed by a privileged `RULES_MANAGEMENT_ROLE`.
- Child rules are read-only (`view`) — no reentrancy risk.
- Gas cost scales linearly with the number of rules, which is expected and documented.

---

## assembly (Informational) — ID-23

**Verdict: Acknowledged — by design**

Flagged location: `RuleConditionalTransferLightBase._transferHash(address,address,uint256)` uses inline assembly (lines 180–186).

The assembly block computes a compact hash of the transfer parameters (`from`, `to`, `value`) using `mstore` and `keccak256`. This is an intentional micro-optimisation: it produces an `abi.encodePacked`-equivalent layout without allocating a new memory buffer, saving gas on every approval lookup. The assembly is minimal, well-scoped, and does not involve any control-flow or external calls. No safety concern.

---

## missing-inheritance (Informational) — ID-24

**Verdict: Acknowledged — mock contract**

Flagged location: `TotalSupplyMock` should inherit from `ITotalSupply`.

`TotalSupplyMock` is a test-only mock located in `src/mocks/`. It implements the `totalSupply()` function to simulate a token for testing `RuleMaxTotalSupply` without deploying a full ERC-20. Declaring `ITotalSupply` inheritance would add no behaviour and is unnecessary for testing purposes. No change planned.

---

## naming-convention (Informational) — ID-25, ID-26

**Verdict: Acknowledged**

Parameters `_operator` in `RuleERC2980Base.frozenlist(address)` and `RuleERC2980Base.whitelist(address)` use a leading underscore. These names are taken directly from the ERC-2980 specification interface, which defines `frozenlist(address _operator)` and `whitelist(address _operator)`. Renaming them would diverge from the standard. No change planned.

---

## unindexed-event-address (Informational) — ID-27, ID-28

**Verdict: Out of scope**

Both remaining instances (`IERC3643Compliance.TokenBound` and `IERC3643Compliance.TokenUnbound`) are defined in `lib/RuleEngine` — a dependency library outside this repository. No action possible.

Note: the previously reported `IAddressList.AddAddress` and `IAddressList.RemoveAddress` findings have been **fixed** — both events now have `indexed` address parameters.

---

## unused-state (Informational) — ID-29 to ID-88

**Verdict: False positive**

All 60 instances report `RuleNFTAdapter` selector constants (`TRANSFERRED_SELECTOR_ERC3643`, `TRANSFERRED_SELECTOR_RULE_ENGINE`, `TRANSFERRED_SELECTOR_ERC7943`, `TRANSFERRED_SELECTOR_ERC7943_FROM`) as unused in specific concrete contracts.

These constants are defined in `RuleNFTAdapter` and used by its internal dispatch logic. Slither performs a per-concrete-contract analysis and flags constants not directly referenced in a given contract's own bytecode, even though they are active in the inherited base. This is a known limitation of Slither's inheritance analysis for `constant` values defined in base contracts.

---

## Summary

| Category | Severity | IDs | Verdict |
|---|---|---|---|
| arbitrary-send-erc20 | High | ID-0 | False positive |
| unused-return | Medium | ID-1 to ID-6 | False positive |
| calls-loop | Low | ID-7 to ID-22 | Acknowledged — by design |
| assembly | Informational | ID-23 | Acknowledged — by design |
| missing-inheritance | Informational | ID-24 | Acknowledged — mock contract |
| naming-convention | Informational | ID-25 to ID-26 | Acknowledged |
| unindexed-event-address | Informational | ID-27 to ID-28 | Out of scope (lib/) |
| unused-state | Informational | ID-29 to ID-88 | False positive |
