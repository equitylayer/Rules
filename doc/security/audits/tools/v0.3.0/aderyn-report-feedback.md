# Aderyn Report — Feedback

Report version: `v0.3.0`
Aderyn report: [aderyn-report.md](./aderyn-report.md)
Feedback date: 2026-04-16

This document provides the project team's assessment of each finding reported by the Aderyn static analyser. For each issue the verdict is one of:

| Verdict | Meaning |
|---|---|
| **Acknowledged** | Known, accepted by design; no change planned. |
| **Acknowledged — low impact** | Technically valid but the actual risk is negligible given context. |
| **Fixed** | Resolved in the codebase. |
| **To fix** | Will be addressed in a future revision. |
| **False positive** | Tool mis-identification; no real issue exists. |

---

## L-1: Centralization Risk

**Verdict: Acknowledged — by design**

This library implements compliance rules for regulated security tokens (CMTAT / ERC-3643). Admin and operator roles are intentionally held by the issuer/compliance operator. This is an explicit trust assumption, not an implementation bug.

---

## L-2: Unspecific Solidity Pragma

**Verdict: Acknowledged — by design**

The repository intentionally uses `pragma solidity ^0.8.20` to keep the library integrator-friendly while the project itself remains deterministic via `foundry.toml` (`solc = 0.8.34`).

---

## L-3: Address State Variable Set Without Checks

**Verdict: False positive**

Flagged location: assignment in `RuleSanctionsListBase._setSanctionListOracle`.

The zero-address guard is enforced at the public boundary in `setSanctionListOracle(...)`. The internal setter accepts `address(0)` intentionally because `clearSanctionListOracle()` must disable the oracle.

---

## L-4: PUSH0 Opcode

**Verdict: Acknowledged — not applicable**

The project targets `evm_version = "prague"` in `foundry.toml`, and deployment targets are expected to support Shanghai+ opcodes including `PUSH0`.

---

## L-5: Modifier Invoked Only Once

**Verdict: Acknowledged — by design (template method pattern)**

Flagged modifiers (e.g., `onlyCheckSpenderManager`) are deliberate authorization wrappers over abstract `_authorize*` hooks. Inlining would weaken consistency across AccessControl and Ownable variants.

---

## L-6: Empty Block

**Verdict: Acknowledged — by design (template method pattern / interface compliance)**

Most empty blocks are `_authorize*` hook implementations where the check is provided by modifiers (`onlyRole`, `onlyOwner`).

Other empty functions are intentional no-ops required by shared interfaces in rules that are read-only for specific paths.

---

## L-7: Costly operations inside loop

**Verdict: Acknowledged — unavoidable**

Flagged loops perform `EnumerableSet` insert/remove operations across batch APIs. These operations are inherently storage writes (`SSTORE`) per item, so linear gas growth is expected and unavoidable.

---

## L-8: Unchecked Return

**Verdict: Mixed — see per-instance analysis below**

| Instance | Assessment |
|---|---|
| `_grantRole(DEFAULT_ADMIN_ROLE, admin)` in `AccessControlModuleStandalone` | **Acknowledged / low impact** — constructor path; duplicate grant would simply return `false` and is not expected on fresh deployment. |
| `_addAddresses(...)` / `_removeAddresses(...)` batch helpers | **False positive** — `void` helpers, no return value to check. |
| `_listedAddresses.add/remove` in `RuleAddressSetInternal` single-item helpers | **False positive** — correctness guaranteed by outer pre-checks in public single-item methods. |
| `_whitelist.add/remove` and `_frozenlist.add/remove` in `RuleERC2980Internal` single-item helpers | **False positive** — same pre-check pattern as above. |
| `_addWhitelistAddresses` / `_removeWhitelistAddresses` / `_addFrozenlistAddresses` / `_removeFrozenlistAddresses` | **False positive** — batch helper path, no unchecked boolean return at API boundary. |

---

## Summary

| ID | Title | Verdict |
|---|---|---|
| L-1 | Centralization Risk | Acknowledged — by design |
| L-2 | Unspecific Solidity Pragma | Acknowledged — by design |
| L-3 | Address State Variable Set Without Checks | False positive |
| L-4 | PUSH0 Opcode | Acknowledged — not applicable |
| L-5 | Modifier Invoked Only Once | Acknowledged — by design |
| L-6 | Empty Block | Acknowledged — by design |
| L-7 | Costly operations inside loop | Acknowledged — unavoidable |
| L-8 | Unchecked Return | Mixed (majority false positives) |
