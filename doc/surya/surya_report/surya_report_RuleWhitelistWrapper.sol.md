## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/RuleWhitelistWrapper.sol | 741da016c14aa771d10f07b3eb3afad5321a69f2 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleWhitelistWrapper** | Implementation | RuleWhitelistWrapperBase, AccessControlModuleStandalone |||
| └ | <Constructor> | Public ❗️ | 🛑  | RuleWhitelistWrapperBase AccessControlModuleStandalone |
| └ | hasRole | Public ❗️ |   |NO❗️ |
| └ | _authorizeCheckSpenderManager | Internal 🔒 | 🛑  | |
| └ | _onlyRulesManager | Internal 🔒 | 🛑  | onlyRole |
| └ | _msgSender | Internal 🔒 |   | |
| └ | _msgData | Internal 🔒 |   | |
| └ | _contextSuffixLength | Internal 🔒 |   | |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
