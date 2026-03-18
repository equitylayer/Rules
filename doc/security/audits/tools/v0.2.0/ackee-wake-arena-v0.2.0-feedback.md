# Wake Arena (Ackee Blockchain Security) — Feedback

**Report date:** 2026-03-16
**Tool:** Wake Arena (AI-assisted static analysis)
**Audited commit:** `d72a98abbba29cd82a7056b59104e82ac65389e7`
**Report file:** [ackee-wake-arenav0.2.0.pdf](./ackee-wake-arenav0.2.0.pdf)
**Feedback date:** 2026-03-18

---

## Summary

| ID | Title | Severity | Confidence | Verdict |
|----|-------|----------|------------|---------|
| H1 | ConditionalTransferLight approvals not scoped by token | High | High | **Fixed** |
| M1 | Incomplete `supportsInterface` breaks ERC-165 discovery | Medium | High | **Fixed** |
| I1 | RuleERC2980 docs omit frozen spender on `transferFrom` | Info | High | **Fixed (doc only)** |
| I2 | `hasRole` override: admin implicitly passes all role checks | Info | High | **Fixed (doc only)** |

---

## H1 — ConditionalTransferLight approvals not scoped by token

**Severity:** High | **Confidence:** High | **Verdict: Fixed**

### Finding

`approvalCounts` in `RuleConditionalTransferLightBase` was keyed exclusively by
`_transferHash(from, to, value)` — a keccak256 of the three packed arguments — with no
token address in the key.

`_authorizeTransferExecution()` only verified that `msg.sender` was a bound token via
`isTokenBound(_msgSender())`, without verifying *which* token the approval was created
for. Because `ERC3643ComplianceModule` supported multiple simultaneous token bindings via
an `EnumerableSet.AddressSet`, a single rule instance could be bound to Token A and
Token B at the same time, allowing approvals recorded for one token to be consumed by the
other.

Three concrete attack vectors were identified:

1. **Cross-token replay** — an approval created by Token A's operator can be consumed by
   a `transferred` call from Token B.
2. **Approval draining / DoS** — a malicious operator on Token B deliberately consumes
   approvals meant for Token A, preventing legitimate transfers.
3. **Rebinding hazard** — stale approvals survive an unbind/rebind cycle and can be
   consumed by a new token.

### Assessment

Valid and actionable. The exploit requires no elevated privilege beyond being an operator
of a second bound token.

### Fix

**Commit:** `2e41c72`

Single-token binding is enforced by overriding `bindToken` in
`RuleConditionalTransferLightBase`:

```solidity
function bindToken(address token) public override onlyComplianceManager {
    require(getTokenBound() == address(0), RuleConditionalTransferLight_TokenAlreadyBound());
    _bindToken(token);
}
```

A second `bindToken` call now reverts with `RuleConditionalTransferLight_TokenAlreadyBound`.
To migrate to a new token the compliance manager must first call `unbindToken`.

This eliminates vectors 1 and 2 entirely. Vector 3 (stale approvals after an explicit
unbind/rebind) remains a conscious operator decision — the operator who controls rebinding
also controls approvals — and is documented in NatSpec on `bindToken`.

The error `RuleConditionalTransferLight_TokenAlreadyBound` was added to
`RuleConditionalTransferLightInvariantStorage`. Tests added:
`testBindToken_RevertsIfAlreadyBound` and `testBindToken_RevertsForUnauthorizedCaller`.

As a follow-up refactor (commit `7e3abb2`) the base contract was split into
`RuleConditionalTransferLightApprovalBase` (pure approval state machine) and
`RuleConditionalTransferLightBase` (ERC-3643 / IRule compliance integration). The
`bindToken` guard and `_authorizeTransferExecution` were consolidated into the base to
eliminate duplication between the AccessControl and Ownable2Step variants.
`RuleConditionalTransferLightOwnable2Step` was also updated to inherit
`ERC3643ComplianceModule` for consistency.

---

## M1 — Incomplete `supportsInterface` breaks ERC-165 discovery

**Severity:** Medium | **Confidence:** High | **Verdict: Fixed**

### Finding

`RuleTransferValidation.supportsInterface` only declared `type(IRule).interfaceId` and
`RuleInterfaceId.IRULE_INTERFACE_ID`, omitting `IERC165`, `IERC1404`, `IERC1404Extend`,
`IERC3643ComplianceRead`, and `IERC7551Compliance`.

`RuleConditionalTransferLight.supportsInterface` delegated to
`AccessControlEnumerable.supportsInterface` (covering `IERC165`, `IAccessControl`,
`IAccessControlEnumerable`) but omitted `IERC1404`, `IERC1404Extend`,
`IERC3643ComplianceRead`, `IERC7551Compliance`, and `IERC3643IComplianceContract`.

Silent `false` responses from `supportsInterface` cause integration failures or silent
enforcement bypasses in tools and front-ends that use ERC-165 introspection to verify
rule capabilities before wiring them.

### Assessment

Valid. The gap is directly observable from source. `type(IFoo).interfaceId` in Solidity
only XORs selectors defined directly on `IFoo` and does **not** include selectors from
inherited interfaces — a subtle but critical point for hierarchical compliance interfaces.

### Fix

**Commit:** `5500a74` (initial fix) — follow-up additions below.

Pre-computed library constants from CMTAT are used in place of raw `type(X).interfaceId`
calls:

- `ERC1404ExtendInterfaceId.ERC1404EXTEND_INTERFACE_ID` (`0x78a8de7d`) — covers the full
  ERC-1404 / ERC-1404-Extend compliance interface family
- `RuleEngineInterfaceId.RULE_ENGINE_INTERFACE_ID` (`0x20c49ce7`) — covers `IRuleEngine`
- `RuleInterfaceId.IRULE_INTERFACE_ID` (`0x2497d6cb`) — covers `IRule`

Two further interfaces were added as follow-up:

- `type(IERC7551Compliance).interfaceId` (`0x7157797f`) — single selector
  `canTransferFrom(address,address,address,uint256)`; safe to use `type(X).interfaceId`
  directly because `IERC7551Compliance` defines exactly one function.
- For **validation rules** (`RuleTransferValidation` and all subclasses):
  `type(IERC3643IComplianceContract).interfaceId` — single selector
  `transferred(address,address,uint256)`; also safe to use directly.
- For **`RuleConditionalTransferLight`** and **`RuleConditionalTransferLightOwnable2Step`**:
  instead of the narrow `IERC3643IComplianceContract`, the full ERC-3643 `ICompliance`
  interface ID is advertised via the flat mock `IERC3643ComplianceFull`
  (`src/mocks/IERC3643ComplianceFull.sol`, `0x3144991c`). These contracts implement all
  eight `ICompliance` functions (`bindToken`, `unbindToken`, `isTokenBound`,
  `getTokenBound`, `canTransfer`, `transferred`, `created`, `destroyed`). Using
  `type(IERC3643Compliance).interfaceId` directly would be wrong because it only XORs
  the seven selectors defined directly on `IERC3643Compliance`, missing `canTransfer`
  and `transferred` which come from parent interfaces. The flat mock redeclares all eight
  so the XOR is correct.

Final state of each `supportsInterface`:

**`RuleTransferValidation`** (cascades to all validation rules):

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
    return interfaceId == RuleEngineInterfaceId.RULE_ENGINE_INTERFACE_ID
        || interfaceId == ERC1404ExtendInterfaceId.ERC1404EXTEND_INTERFACE_ID
        || interfaceId == RuleInterfaceId.IRULE_INTERFACE_ID
        || interfaceId == type(IERC7551Compliance).interfaceId
        || interfaceId == type(IERC3643IComplianceContract).interfaceId;
}
```

**`RuleConditionalTransferLight`**:

```solidity
function supportsInterface(bytes4 interfaceId)
    public view virtual override(AccessControlEnumerable, IERC165) returns (bool)
{
    return interfaceId == RuleEngineInterfaceId.RULE_ENGINE_INTERFACE_ID
        || interfaceId == ERC1404ExtendInterfaceId.ERC1404EXTEND_INTERFACE_ID
        || interfaceId == RuleInterfaceId.IRULE_INTERFACE_ID
        || interfaceId == type(IERC7551Compliance).interfaceId
        || interfaceId == type(IERC3643ComplianceFull).interfaceId
        || AccessControlEnumerable.supportsInterface(interfaceId);
}
```

**`RuleConditionalTransferLightOwnable2Step`**:

```solidity
function supportsInterface(bytes4 interfaceId) public view override returns (bool) {
    return interfaceId == type(IERC165).interfaceId
        || interfaceId == RuleEngineInterfaceId.RULE_ENGINE_INTERFACE_ID
        || interfaceId == ERC1404ExtendInterfaceId.ERC1404EXTEND_INTERFACE_ID
        || interfaceId == RuleInterfaceId.IRULE_INTERFACE_ID
        || interfaceId == type(IERC7551Compliance).interfaceId
        || interfaceId == type(IERC3643ComplianceFull).interfaceId;
}
```

The convention is now documented in `CLAUDE.md` and `AGENTS.md`:
> `type(IFoo).interfaceId` only XORs selectors defined directly on `IFoo`. Always use
> pre-computed library constants. If no constant exists, define a flat mock interface
> that redeclares the full inheritance tree and use `type(IFooFlattened).interfaceId`.

---

## I1 — RuleERC2980 docs omit frozen spender on `transferFrom`

**Severity:** Info | **Confidence:** High | **Verdict: Fixed (doc only)**

### Finding

`RuleERC2980Base._detectTransferRestrictionFrom` correctly returns
`CODE_ADDRESS_SPENDER_IS_FROZEN` (code 62) when `_isFrozen(spender)` is true. However,
the README, `AGENTS.md`, and `CLAUDE.md` described the frozenlist as blocking only
`from` and `to`:

> "frozen addresses are completely blocked — they can neither send nor receive tokens"

The spender path for `transferFrom` was never mentioned, causing integrators to not
anticipate that freezing an exchange or escrow address also blocks its `transferFrom`
delegation.

### Assessment

Valid — code is correct, documentation is incomplete. No security vulnerability: the
behaviour is more restrictive (safer) than documented, so no funds can be stolen, only
unexpected reverts.

### Fix

**Commit:** `8926e0a`

Documentation updated in `README.md`, `AGENTS.md`, and `CLAUDE.md`:

> "Frozen addresses are completely blocked — they can neither send nor receive tokens.
> Additionally, a frozen address acting as a `transferFrom` spender will have the
> transfer rejected (code 62), even if `from` and `to` are not frozen."

The `RuleERC2980` summary table row was updated to:

> "ERC-2980 Swiss Compliant rule: whitelist (recipient-only) + frozenlist (blocks
> sender, recipient, **and spender for `transferFrom`**); frozenlist takes priority."

---

## I2 — `hasRole` override: admin implicitly passes all role checks

**Severity:** Info | **Confidence:** High | **Verdict: Fixed (doc only)**

### Finding

`AccessControlModuleStandalone.hasRole` overrides the OpenZeppelin implementation so that
any account holding `DEFAULT_ADMIN_ROLE` returns `true` for every role check:

```solidity
if (AccessControl.hasRole(DEFAULT_ADMIN_ROLE, account)) {
    return true;
}
```

This diverges from standard OpenZeppelin semantics where `DEFAULT_ADMIN_ROLE` only
controls who can grant/revoke other roles. Consequences noted by the auditor:

- `grantRole` to a default admin is a no-op — `_grantRole` skips storage and no
  `RoleGranted` event is emitted; the admin is absent from enumeration.
- `revokeRole` / `renounceRole` emit `RoleRevoked` and clear storage, but `hasRole`
  continues to return `true`. Effective access is unchanged.
- Off-chain monitoring relying on events or enumerable queries will incorrectly believe
  the admin lost a role.

### Assessment

**Intentional by design — no code change.** The OpenZeppelin `DEFAULT_ADMIN_ROLE` holder
can already grant itself any role at any time. Treating it as implicitly holding all roles
removes unnecessary ceremony and simplifies access management for regulated token issuers.
The misleading event and enumeration behaviour is acknowledged and documented.

### Fix

**Commit:** `769ec2d`

A dedicated sub-section added to `README.md` under *Access Control* documenting:

- The intentional `hasRole` override and its rationale.
- `grantRole` no-op behaviour and enumeration absence for admin accounts.
- `revokeRole` / `renounceRole` misleading semantics; `DEFAULT_ADMIN_ROLE` itself must be
  revoked to fully remove access.
- Recommendation for off-chain tooling to use `hasRole` queries rather than role events
  or enumeration.

**Possible future improvement:** introduce a `hasPermission` helper alongside a dedicated
`onlyRoleOrAdmin` modifier, keeping `hasRole` standard (no override) while preserving the
admin bypass only where explicitly needed:

```solidity
function hasPermission(bytes32 role, address account) public view returns (bool) {
    return AccessControl.hasRole(DEFAULT_ADMIN_ROLE, account)
        || AccessControl.hasRole(role, account);
}

modifier onlyRoleOrAdmin(bytes32 role) {
    require(hasPermission(role, _msgSender()), ...);
    _;
}
```

This would restore event and enumeration consistency without changing the effective access
model.
