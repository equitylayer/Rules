## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/abstract/base/RuleWhitelistBase.sol | c294dd72e48d0a71699d3b54c560e1e5c23d52da |


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
