## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/abstract/base/RuleWhitelistBase.sol | 3dc6bbac3c9d6bbbb012578f4d0ecd1fd790f44c |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleWhitelistBase** | Implementation | RuleAddressSet, RuleWhitelistShared, IIdentityRegistryVerified |||
| └ | <Constructor> | Public ❗️ | 🛑  | RuleAddressSet |
| └ | setCheckSpender | Public ❗️ | 🛑  | onlyCheckSpenderManager |
| └ | isVerified | Public ❗️ |   |NO❗️ |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | _authorizeCheckSpenderManager | Internal 🔒 |   | |
| └ | _detectTransferRestriction | Internal 🔒 |   | |
| └ | _detectTransferRestrictionFrom | Internal 🔒 |   | |
| └ | _setCheckSpender | Internal 🔒 | 🛑  | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
