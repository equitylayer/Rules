# Slither Report — Feedback

Report version: `v0.3.0`
Slither report: [slither-report.md](./slither-report.md)
Feedback date: 2026-04-16

Verdicts:

| Verdict | Meaning |
|---|---|
| **Acknowledged** | Known, accepted by design; no change planned. |
| **Acknowledged — low impact** | Technically valid but actual risk is negligible given context. |
| **Fixed** | Resolved in the codebase. |
| **To fix** | Will be addressed in a future revision. |
| **False positive** | Tool mis-identification; no real issue exists. |
| **Out of scope** | Reported location is in dependency code outside this repository. |

---

## arbitrary-send-erc20 (High) — ID-0

**Verdict: False positive**

Flagged function: `RuleConditionalTransferLightBase.approveAndTransferIfAllowed(...)`.

`from` is a parameter, but this is not an arbitrary-drain primitive because:

1. Function access is restricted by `onlyTransferApprover`.
2. The contract checks `allowance(from, address(this)) >= value` before transfer.
3. The call path is part of a deliberate compliance workflow and executes against the single bound token.

Using `SafeERC20.safeTransferFrom` does not change this authorization model; it only hardens ERC-20 return handling.

---

## unused-return (Medium) — ID-1 to ID-6

**Verdict: False positive**

Flagged calls are `EnumerableSet.add/remove` in internal single-item helpers. The external/public single-item entrypoints already perform precondition checks (present/not present), making the boolean return redundant in those internal helper implementations.

---

## calls-loop (Low) — ID-7 to ID-22

**Verdict: Acknowledged — by design**

All instances stem from `RuleWhitelistWrapperBase._detectTransferRestrictionForTargets(...)`, which must query child whitelist rules to implement OR aggregation. External calls in this loop are intrinsic to the wrapper design.

---

## assembly (Informational) — ID-23

**Verdict: Acknowledged — by design**

`RuleConditionalTransferLightApprovalBase._transferHash(...)` uses a small, memory-safe assembly block to compute transfer tuple hash efficiently. This is intentional and bounded.

---

## naming-convention (Informational) — ID-24 to ID-25

**Verdict: Acknowledged**

`_operator` naming in `RuleERC2980Base.whitelist/frozenlist` mirrors the ERC-2980 interface naming. Keeping spec-aligned argument names is intentional.

---

## unindexed-event-address (Informational) — ID-26 to ID-27

**Verdict: Out of scope**

Both findings point to `lib/RuleEngine/src/interfaces/IERC3643Compliance.sol`, which is a dependency module under `lib/` and not maintained in this repository.

---

## unused-state (Informational) — ID-28 to ID-35

**Verdict: False positive**

All instances are `RuleNFTAdapter` selector constants reported as unused in specific concrete contracts. They are part of inherited dispatch logic and are used across adapter paths; this is a per-contract inheritance analysis limitation.

---

## Summary

| Category | Severity | IDs | Verdict |
|---|---|---|---|
| arbitrary-send-erc20 | High | ID-0 | False positive |
| unused-return | Medium | ID-1 to ID-6 | False positive |
| calls-loop | Low | ID-7 to ID-22 | Acknowledged — by design |
| assembly | Informational | ID-23 | Acknowledged — by design |
| naming-convention | Informational | ID-24 to ID-25 | Acknowledged |
| unindexed-event-address | Informational | ID-26 to ID-27 | Out of scope (lib/) |
| unused-state | Informational | ID-28 to ID-35 | False positive |
