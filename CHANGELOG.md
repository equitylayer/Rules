# CHANGELOG

Please follow [https://changelog.md/](https://changelog.md/) conventions.

## Semantic Version 2.0.0

Given a version number MAJOR.MINOR.PATCH, increment the:

1. MAJOR version when the new version makes:
   -  Incompatible proxy **storage** change internally or through the upgrade of an external library (OpenZeppelin)
   -  A significant change in external APIs (public/external functions) or in the internal architecture
2. MINOR version when the new version adds functionality in a backward compatible manner
3. PATCH version when the new version makes backward compatible bug fixes

See [https://semver.org](https://semver.org)

## Type of changes

- `Added` for new features.
- `Changed` for changes in existing functionality.
- `Deprecated` for soon-to-be removed features.
- `Removed` for now removed features.
- `Fixed` for any bug fixes.
- `Security` in case of vulnerabilities.

Reference: [keepachangelog.com/en/1.1.0/](https://keepachangelog.com/en/1.1.0/)

Custom changelog tag: `Dependencies`, `Documentation`, `Testing`

## Checklist

> Before a new release, perform the following tasks

- Code: Update the version name, variable VERSION
- Run formatter and linter

> forge fmt
> forge lint

- Documentation
  - Perform a code coverage and update the files in the corresponding directory [./doc/coverage](./doc/coverage)
  - Perform an audit with several audit tools (Mythril and Slither), update the report in the corresponding directory [./doc/security/audits/tools](./doc/security/audits/tools)
  - Update surya doc by running the 3 scripts in [./doc/script](./doc/script)
  - Update changelog

## v0.2.0 - TBD

Commit: `TBD`

### Added

- `RuleERC2980` — ERC-2980 Swiss Compliant rule combining a whitelist (recipient-only) and a frozenlist (blocks sender, recipient, and spender); frozenlist takes priority. Restriction codes 60–63.
- `RuleERC2980Ownable2Step` — Ownable2Step variant of `RuleERC2980`.
- `IERC2980` interface with NatSpec documenting the deviation from the ERC example interfaces (single-item functions revert on invalid input rather than returning `bool`).
- `isVerified(address)` to `RuleERC2980Base` and `RuleWhitelistWrapperBase`, implementing `IIdentityRegistryVerified`; for ERC-2980 it reflects whitelist membership only (frozen status is excluded).
- `VersionModule` — abstract module implementing `IERC3643Version`; all rules now expose `version()` returning `"0.2.0"`.
- New deployable rules: `RuleIdentityRegistry`, `RuleMaxTotalSupply`, `RuleConditionalTransferLight`.
- Ownable2Step variants for all rules: `RuleWhitelistOwnable2Step`, `RuleBlacklistOwnable2Step`, `RuleSanctionsListOwnable2Step`, `RuleMaxTotalSupplyOwnable2Step`, `RuleIdentityRegistryOwnable2Step`, `RuleWhitelistWrapperOwnable2Step`, `RuleConditionalTransferLightOwnable2Step`.
- Transfer-context struct API: `MultiTokenTransferContext` / `FungibleTransferContext` with an extra `data` field.
- Explicit sanctions oracle clearing via `clearSanctionListOracle()`.
- CMTAT deployment scripts for whitelist and blacklist configurations.
- `DeployCMTATWithBlacklistAndSanctionsList` deployment script — deploys a CMTAT token wired to a `RuleEngine` configured with both `RuleBlacklist` and `RuleSanctionsList`.
- Technical documentation for all rules in `doc/technical/`: added `RuleMaxTotalSupply.md`, `RuleIdentityRegistry.md`, `RuleERC2980.md`, `RuleConditionalTransferLight.md`; updated `RuleWhitelist.md`, `RuleBlacklist.md`, `RuleSanctionList.md`, `RuleWhitelistWrapper.md`.

### Changed

- RBAC variants now use `AccessControlEnumerable` (replacing plain `AccessControl`); role members can be enumerated with `getRoleMember` / `getRoleMemberCount`.
- Default admin implicitly holds all roles via a `hasRole` override; may not appear in role member enumerations unless explicitly granted.
- Authorization hooks (`_authorize*()`) now use `onlyRole(ROLE)` modifier instead of direct `_checkRole` calls.
- All `internal` functions marked `virtual` to allow downstream overriding.
- Validation flow refactored to internal hooks (no `this.` calls) via `RuleTransferValidation` and `RuleNFTAdapter`.
- `RuleConditionalTransferLight` and `RuleMaxTotalSupply` are ERC-20 only; ERC-721/1155 compliance interfaces are limited to validation rules.
- Address list batch updates emit only add/remove events (no summary events).
- Reorganized validation contracts into `abstract/base`, `abstract/core`, `abstract/invariant`, and `deployment` folders.

### Dependencies

- Updated Solidity toolchain to 0.8.34.
- Update OpenZeppelin to 5.6.0
- Update CMTAT to v3.2.0
- Update RuleEngine to v3.0.0-rc1

### Documentation

- Access-control role table with keccak256 hashes.
- Rule-engine flow diagrams, API accuracy, directory layout notes.
- Static analysis reports (Aderyn, Slither) with project feedback in `doc/security/audits/tools/v0.2.0/`.
- Gas benchmarks in `doc/GAS.md` and `.gas-snapshot`.

## v0.1.0 - 2025-12-03

Commit: `09376412269d2397fa7db6562e63bc65376d12b9`

First release !

- Update Rules to CMTAT v3.0.0 and latest RuleEngine version

- Use [EnumerableSet](https://docs.openzeppelin.com/contracts/5.x/api/utils#EnumerableSet) from OpenZeppelin to store address status for blacklist and whitelist rules.
- Add function `canTransferFrom`, `detectTransferRestrictionFrom` which takes the spender argument
- Add functions `canTransfer`, `canTransferFrom`, `detectTransferRestriction`,`detectTransferRestrictionFrom` which takes the `tokenId` argument.
- Add support of [ERC-165](https://eips.ethereum.org/EIPS/eip-165) in each rule.
