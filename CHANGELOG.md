# CHANGELOG

Please follow [https://changelog.md/](https://changelog.md/) conventions.

## Checklist

> Before a new release, perform the following tasks

- Code: Update the version name, variable VERSION
- Run linter

> npm run-script lint:all:prettier

- Documentation
  - Perform a code coverage and update the files in the corresponding directory [./doc/coverage](./doc/coverage)
  - Perform an audit with several audit tools (Mythril and Slither), update the report in the corresponding directory [./doc/security/audits/tools](./doc/security/audits/tools)
  - Update surya doc by running the 3 scripts in [./doc/script](./doc/script)
  - Update changelog

## v0.2.0 - TBD

Commit: `TBD`

Main changes since v0.1.0:

- Updated Solidity toolchain to 0.8.34 (Foundry/Hardhat).
- Introduced `TransferContext` struct API and unified transfer hooks.
- Refactored validation flow to internal hooks (no `this.` calls) via `RuleTransferValidation` and `RuleNFTAdapter`.
- Added explicit sanctions oracle clearing (`clearSanctionListOracle`) and tightened oracle zero‑address handling.
- Added batch summary events for address list updates.
- Added deployable rules: `RuleIdentityRegistry`, `RuleMaxTotalSupply`, `RuleConditionalTransferLight`.
- Reorganized validation contracts into `abstract/base`, `abstract/core`, `abstract/invariant`, and `deployment` folders.
- Updated documentation: access‑control role table with hashes, rule‑engine flow diagrams, API accuracy, directory layout notes.

## v0.1.0 - 2025-12-03

Commit: `09376412269d2397fa7db6562e63bc65376d12b9`

First release !

- Update Rules to CMTAT v3.0.0 and latest RuleEngine version

- Use [EnumerableSet](https://docs.openzeppelin.com/contracts/5.x/api/utils#EnumerableSet) from OpenZeppelin to store address status for blacklist and whitelist rules.
- Add function `canTransferFrom`, `detectTransferRestrictionFrom` which takes the spender argument
- Add functions `canTransfer`, `canTransferFrom`, `detectTransferRestriction`,`detectTransferRestrictionFrom` which takes the `tokenId` argument.
- Add support of [ERC-165](https://eips.ethereum.org/EIPS/eip-165) in each rule.
