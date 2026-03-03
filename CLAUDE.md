# Project Guide

## Purpose
Modular compliance-rule library for CMTAT / ERC-3643 security tokens. Each rule enforces a transfer restriction (whitelist, blacklist, sanctions, max supply, identity, conditional approval) and can be used standalone or composed via a `RuleEngine`.

## Key Directories
| Path | Description |
|---|---|
| `src/rules/validation/` | Read-only rules (view functions, no state changes during transfer) |
| `src/rules/operation/` | Read-write rules (modify state on transfer) |
| `src/rules/validation/abstract/` | Shared base contracts and invariant storage |
| `src/rules/interfaces/` | Shared interfaces (`IAddressList`, `IIdentityRegistry`, `ISanctionsList`) |
| `src/modules/` | Reusable modules (`AccessControlModuleStandalone`, `MetaTxModuleStandalone`) |
| `test/` | Foundry tests, one folder per rule |
| `lib/` | Git submodule dependencies (do not edit) |

## Main Contracts
| Contract | Role |
|---|---|
| `RuleWhitelist` / `RuleWhitelistOwnable` | Allow transfers only between whitelisted addresses |
| `RuleWhitelistWrapper` / `Ownable2Step` | Aggregate multiple whitelist rules (OR logic) |
| `RuleBlacklist` / `RuleBlacklistOwnable` | Block transfers involving blacklisted addresses |
| `RuleSanctionsList` | Block sanctioned addresses via Chainalysis oracle |
| `RuleMaxTotalSupply` | Cap minting so total supply never exceeds a maximum |
| `RuleIdentityRegistry` | Check ERC-3643 identity registry for participant verification |
| `RuleConditionalTransferLight` | Require operator approval before each transfer |
| `AccessControlModuleStandalone` | Base RBAC module; admin implicitly holds all roles |
| `MetaTxModuleStandalone` | ERC-2771 meta-transaction support |

## Dependencies (lib/)
- `openzeppelin-contracts` v5.5.0 — `AccessControl`, `Ownable2Step`, `EnumerableSet`, `ERC2771Context`
- `CMTAT` v3.0.0 — `IERC1404`, `IERC3643`, `IRuleEngine` interfaces
- `RuleEngine` v3.0.0-rc0 — `IRule`, `RulesManagementModule`
- `forge-std` — Foundry test utilities

Remappings are in `remappings.txt`; aliases used in source: `OZ/`, `CMTAT/`, `RuleEngine/`.

## Toolchain
```bash
forge build          # compile
forge test           # run all tests
forge test -vvv      # verbose output
```
Foundry config: `foundry.toml` (solc 0.8.30, EVM prague, optimizer 200 runs).

## Restriction Code Ranges
| Rule | Codes |
|---|---|
| RuleWhitelist | 21–23 |
| RuleSanctionsList | 30–32 |
| RuleBlacklist | 36–38 |
| RuleConditionalTransferLight | 71 |
| RuleMaxTotalSupply | 80 |
| RuleIdentityRegistry | 90–92 |

## Conventions
- Each rule has an `InvariantStorage` abstract contract holding its constants, custom errors, and events.
- Access control is implemented via an abstract `_authorize*()` method overridden by concrete subclasses (template method pattern).
- Batch add/remove operations are non-reverting (skip duplicates); single-item operations revert on invalid input.
- Do not create git commits; provide commit messages only when requested.
- Always run tests after modifying contracts.
- `AGENTS.md` and `CLAUDE.md` are identical — always update both together.
- Always update README.md with the latest change
