## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/abstract/base/RuleWhitelistWrapperBase.sol | b7d69ae4c5ff3d95b75a3c86e104a1deaf1fb834 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleWhitelistWrapperBase** | Implementation | RulesManagementModule, MetaTxModuleStandalone, RuleWhitelistShared, IIdentityRegistryVerified |||
| └ | <Constructor> | Public ❗️ | 🛑  | MetaTxModuleStandalone |
| └ | _detectTransferRestriction | Internal 🔒 |   | |
| └ | _detectTransferRestrictionFrom | Internal 🔒 |   | |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | isVerified | Public ❗️ |   |NO❗️ |
| └ | setCheckSpender | Public ❗️ | 🛑  | onlyCheckSpenderManager |
| └ | _transferred | Internal 🔒 |   | |
| └ | _transferred | Internal 🔒 |   | |
| └ | _detectTransferRestrictionForTargets | Internal 🔒 |   | |
| └ | _setCheckSpender | Internal 🔒 | 🛑  | |
| └ | _authorizeCheckSpenderManager | Internal 🔒 | 🛑  | |
| └ | _msgSender | Internal 🔒 |   | |
| └ | _msgData | Internal 🔒 |   | |
| └ | _contextSuffixLength | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
