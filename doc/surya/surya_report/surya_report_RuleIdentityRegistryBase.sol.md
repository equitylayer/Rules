## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/abstract/base/RuleIdentityRegistryBase.sol | 47a89ca38792869c7affc9267934137198be36df |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleIdentityRegistryBase** | Implementation | RuleNFTAdapter, RuleIdentityRegistryInvariantStorage |||
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | setIdentityRegistry | Public ❗️ | 🛑  | onlyIdentityRegistryManager |
| └ | clearIdentityRegistry | Public ❗️ | 🛑  | onlyIdentityRegistryManager |
| └ | _detectTransferRestriction | Internal 🔒 |   | |
| └ | _detectTransferRestrictionFrom | Internal 🔒 |   | |
| └ | transferred | Public ❗️ |   |NO❗️ |
| └ | transferred | Public ❗️ |   |NO❗️ |
| └ | _transferred | Internal 🔒 |   | |
| └ | _transferredFrom | Internal 🔒 |   | |
| └ | canReturnTransferRestrictionCode | External ❗️ |   |NO❗️ |
| └ | messageForTransferRestriction | Public ❗️ |   |NO❗️ |
| └ | _authorizeIdentityRegistryManager | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
