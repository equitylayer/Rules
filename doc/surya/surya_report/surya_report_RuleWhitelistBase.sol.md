## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/abstract/RuleWhitelistBase.sol | 7a29774322233b763220069260f15fb07b2d6db8 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleWhitelistBase** | Implementation | RuleAddressSet, RuleWhitelistCommon, IIdentityRegistryVerified |||
| └ | <Constructor> | Public ❗️ | 🛑  | RuleAddressSet |
| └ | _detectTransferRestriction | Internal 🔒 |   | |
| └ | _detectTransferRestrictionFrom | Internal 🔒 |   | |
| └ | isVerified | Public ❗️ |   |NO❗️ |
| └ | setCheckSpender | Public ❗️ | 🛑  | onlyCheckSpenderManager |
| └ | _setCheckSpender | Internal 🔒 | 🛑  | |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | _authorizeCheckSpenderManager | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
