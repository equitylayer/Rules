## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/abstract/base/RuleSanctionsListBase.sol | 4df9987f34a4451f42e019bd7016c6ba51d750b8 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleSanctionsListBase** | Implementation | MetaTxModuleStandalone, RuleNFTAdapter, RuleSanctionsListInvariantStorage |||
| └ | <Constructor> | Public ❗️ | 🛑  | MetaTxModuleStandalone |
| └ | _detectTransferRestriction | Internal 🔒 |   | |
| └ | _detectTransferRestrictionFrom | Internal 🔒 |   | |
| └ | canReturnTransferRestrictionCode | External ❗️ |   |NO❗️ |
| └ | messageForTransferRestriction | Public ❗️ |   |NO❗️ |
| └ | setSanctionListOracle | Public ❗️ | 🛑  | onlySanctionListManager |
| └ | clearSanctionListOracle | Public ❗️ | 🛑  | onlySanctionListManager |
| └ | transferred | Public ❗️ |   |NO❗️ |
| └ | transferred | Public ❗️ |   |NO❗️ |
| └ | _transferred | Internal 🔒 |   | |
| └ | _transferredFrom | Internal 🔒 |   | |
| └ | _setSanctionListOracle | Internal 🔒 | 🛑  | |
| └ | _authorizeSanctionListManager | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
