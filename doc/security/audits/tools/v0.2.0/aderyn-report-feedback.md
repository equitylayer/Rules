# Aderyn Report — Feedback

Report version: `v0.2.0`
Aderyn report: [aderyn-report.md](./aderyn-report.md)
Feedback date: 2026-03-09

This document provides the project team's assessment of each finding reported by the Aderyn static analyser. For each issue the verdict is one of:

| Verdict | Meaning |
|---|---|
| **Acknowledged** | Known, accepted by design; no change planned. |
| **Acknowledged — low impact** | Technically valid but the actual risk is negligible given context. |
| **To fix** | Will be addressed in a future revision. |
| **False positive** | Tool mis-identification; no real issue exists. |

---

## L-1: Centralization Risk

**Verdict: Acknowledged — by design**

This library implements compliance rules for regulated security tokens (CMTAT / ERC-3643). Admin and operator roles are held by the token issuer — a regulated financial entity — not by an anonymous deployer. Privileged access is the intended trust model: an issuer must be able to update whitelists, frozenlist, and oracle addresses to comply with regulatory requirements. The two-step ownership transfer (`Ownable2Step`) and role-based separation (`WHITELIST_ADD_ROLE`, `FROZENLIST_ADD_ROLE`, etc.) already limit the blast radius of a compromised key. No change planned.

---

## L-2: Unsafe ERC20 Operation

**Verdict: Acknowledged — low impact**

Flagged location: `RuleConditionalTransferLightBase.sol` line 59:

```solidity
bool success = IERC20(token).transferFrom(from, to, value);
require(success, RuleConditionalTransferLight_TransferFailed());
```

The return value **is** explicitly checked with `require`. Aderyn flags any direct `.transferFrom` call that does not use `SafeERC20`, but the concern for `SafeERC20` is tokens that return no value (e.g. USDT on mainnet). The token bound to this rule is expected to be a CMTAT-compatible token, which correctly returns a `bool`. The check is already present, so the risk is negligible. `SafeERC20` could be adopted for defence-in-depth; recorded as a potential future hardening item.

---

## L-3: Unspecific Solidity Pragma

**Verdict: Acknowledged — by design**

All source files use `^0.8.20`. This is intentional for a **library**: it allows integrators to compile the contracts with any compatible Solidity version without pinning them to the exact version used internally. The project itself is compiled deterministically with a fixed version (`solc 0.8.34` as specified in `foundry.toml`). The floating pragma carries no deployment risk for the project's own deployments.

---

## L-4: Address State Variable Set Without Checks

**Verdict: False positive**

Flagged location: `RuleSanctionsListBase._setSanctionListOracle` (internal helper). The zero-address check is enforced in the **public-facing function** `setSanctionListOracle` (line 82):

```solidity
require(address(sanctionContractOracle_) != address(0), RuleSanctionsList_OracleAddressZeroNotAllowed());
```

The internal `_setSanctionListOracle` intentionally accepts `address(0)` because it is also called by `removeSanctionListOracle` to explicitly disable the oracle. The guard at the public boundary is sufficient; adding it in the internal helper would break the remove path. No change needed.

---

## L-5: PUSH0 Opcode

**Verdict: Acknowledged — not applicable**

The project targets the **Prague** EVM version (configured in `foundry.toml`), which is a superset of Shanghai. PUSH0 is fully supported on the deployment chains in scope (Ethereum mainnet and EVM-compatible L2s that have adopted Shanghai or later). No change needed.

---

## L-6: Modifier Invoked Only Once

**Verdict: Acknowledged — by design (template method pattern)**

Flagged modifiers: `onlyCheckSpenderManager` in `RuleWhitelistBase` and `RuleWhitelistWrapperBase`.

These modifiers are part of the **template method pattern** used throughout this codebase. The modifier wraps an abstract `_authorizeCheckSpenderManager()` hook that is overridden by concrete subclasses (`RuleWhitelist`, `RuleWhitelistOwnable2Step`, etc.) to enforce access control. Inlining would break the abstraction. The pattern is consistent across all rules and is intentional.

---

## L-7: Empty Block

**Verdict: Acknowledged — by design (template method pattern)**

All `_authorize*()` hook implementations (e.g. `_authorizeWhitelistAdd`, `_authorizeAddressListAdd`) have empty bodies — the access check is performed entirely by the modifier they carry (`onlyRole(ROLE)` or `onlyOwner`). This is the canonical implementation of the template method pattern used here: the body is intentionally empty and the side effect is produced by the modifier.

The `created()` and `destroyed()` hooks in `RuleConditionalTransferLight` are also intentionally no-ops: this rule does not need to react to mint or burn events, but must implement the interface.

---

## L-8: Costly Operations Inside Loop

**Verdict: Acknowledged — unavoidable**

All flagged loops perform `EnumerableSet.add` / `EnumerableSet.remove` calls, each of which is inherently an `SSTORE` operation. These are in batch functions (`_addAddresses`, `_removeAddresses`, `_addWhitelistAddresses`, etc.) whose purpose is to write multiple addresses in a single transaction. There is no way to defer or batch `EnumerableSet` writes to a single storage slot — each element requires its own storage update. The gas cost is linear in the number of addresses and is the unavoidable minimum for this operation. No change planned.

---

## L-9: Unchecked Return

**Verdict: Mixed — see per-instance analysis below**

| Instance | Assessment |
|---|---|
| `_grantRole(DEFAULT_ADMIN_ROLE, admin)` in `AccessControlModuleStandalone` | **False positive / acknowledged** — the code already includes a comment explaining that the return value is intentionally ignored (`false` only when already granted, which cannot happen in a constructor). |
| `_addAddresses(targetAddresses)` / `_removeAddresses(targetAddresses)` in `RuleAddressSet` | **False positive** — these are `void` functions; there is no return value to check. |
| `_listedAddresses.add(targetAddress)` / `.remove(targetAddress)` in `RuleAddressSetInternal` (single-item helpers) | **False positive** — the return value is captured and checked by the calling single-item functions (`_addAddress`, `_removeAddress`) via `require(result, ...)`. Aderyn flags the `.add/.remove` call site inside the helper, not the outer caller where the check occurs. |
| `_whitelist.add/remove` and `_frozenlist.add/remove` in `RuleERC2980Internal` (single-item helpers) | **False positive** — same pattern as above; return is checked by the surrounding `require`. |
| `_addWhitelistAddresses` / `_removeWhitelistAddresses` / `_addFrozenlistAddresses` / `_removeFrozenlistAddresses` in `RuleERC2980Base` | **False positive** — batch helpers return `void`; nothing to check. |

No code changes are required for L-10.

---

## Summary

| ID | Title | Verdict |
|---|---|---|
| L-1 | Centralization Risk | Acknowledged — by design |
| L-2 | Unsafe ERC20 Operation | Acknowledged — low impact |
| L-3 | Unspecific Solidity Pragma | Acknowledged — by design |
| L-4 | Address State Variable Set Without Checks | False positive |
| L-5 | PUSH0 Opcode | Acknowledged — not applicable |
| L-6 | Modifier Invoked Only Once | Acknowledged — by design |
| L-7 | Empty Block | Acknowledged — by design |
| L-8 | Costly Operations Inside Loop | Acknowledged — unavoidable |
| L-9 | Unchecked Return | False positive (all instances) |
