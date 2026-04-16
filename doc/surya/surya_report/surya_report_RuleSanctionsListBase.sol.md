## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/abstract/base/RuleSanctionsListBase.sol | c2e3984467b78f44467fceaeb9773a6dbd98ba83 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleSanctionsListBase** | Implementation | MetaTxModuleStandalone, RuleNFTAdapter, RuleSanctionsListInvariantStorage |||
| └ | <Constructor> | Public ❗️ | 🛑  | MetaTxModuleStandalone |
| └ | canReturnTransferRestrictionCode | External ❗️ |   |NO❗️ |
| └ | setSanctionListOracle | Public ❗️ | 🛑  | onlySanctionListManager |
| └ | clearSanctionListOracle | Public ❗️ | 🛑  | onlySanctionListManager |
| └ | transferred | Public ❗️ |   |NO❗️ |
| └ | transferred | Public ❗️ |   |NO❗️ |
| └ | messageForTransferRestriction | Public ❗️ |   |NO❗️ |
| └ | _authorizeSanctionListManager | Internal 🔒 |   | |
| └ | _detectTransferRestriction | Internal 🔒 |   | |
| └ | _detectTransferRestrictionFrom | Internal 🔒 |   | |
| └ | _transferred | Internal 🔒 |   | |
| └ | _transferredFrom | Internal 🔒 |   | |
| └ | _setSanctionListOracle | Internal 🔒 | 🛑  | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
