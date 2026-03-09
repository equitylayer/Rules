## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/abstract/base/RuleMaxTotalSupplyBase.sol | 0a81c8c5a5216d01bd0432e472aee26135ddb180 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleMaxTotalSupplyBase** | Implementation | RuleTransferValidation, RuleMaxTotalSupplyInvariantStorage |||
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | setMaxTotalSupply | Public ❗️ | 🛑  | onlyMaxTotalSupplyManager |
| └ | setTokenContract | Public ❗️ | 🛑  | onlyMaxTotalSupplyManager |
| └ | _detectTransferRestriction | Internal 🔒 |   | |
| └ | _detectTransferRestrictionFrom | Internal 🔒 |   | |
| └ | transferred | Public ❗️ |   |NO❗️ |
| └ | transferred | Public ❗️ |   |NO❗️ |
| └ | _transferred | Internal 🔒 |   | |
| └ | _transferredFrom | Internal 🔒 |   | |
| └ | canReturnTransferRestrictionCode | External ❗️ |   |NO❗️ |
| └ | messageForTransferRestriction | Public ❗️ |   |NO❗️ |
| └ | _authorizeMaxTotalSupplyManager | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
