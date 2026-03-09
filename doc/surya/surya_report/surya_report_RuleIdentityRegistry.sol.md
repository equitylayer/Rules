## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/RuleIdentityRegistry.sol | c9686af9c46812c57cb5aa3adec6523ccede345d |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleIdentityRegistry** | Implementation | AccessControlModuleStandalone, RuleNFTAdapter, RuleIdentityRegistryInvariantStorage |||
| └ | <Constructor> | Public ❗️ | 🛑  | AccessControlModuleStandalone |
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
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | _authorizeIdentityRegistryManager | Internal 🔒 | 🛑  | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
