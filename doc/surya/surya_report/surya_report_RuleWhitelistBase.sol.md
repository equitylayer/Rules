## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/abstract/base/RuleWhitelistBase.sol | 143951e9f858d05f9ad5d1c1e39879043dd82563 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleWhitelistBase** | Implementation | RuleAddressSet, RuleWhitelistShared, IIdentityRegistryVerified |||
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
