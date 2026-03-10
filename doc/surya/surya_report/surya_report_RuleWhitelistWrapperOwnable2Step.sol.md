## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/deployment/RuleWhitelistWrapperOwnable2Step.sol | ddd7eb760481cd54f2fad6b3665c93e460ba61e6 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleWhitelistWrapperOwnable2Step** | Implementation | RuleWhitelistWrapperBase, Ownable2Step |||
| └ | <Constructor> | Public ❗️ | 🛑  | RuleWhitelistWrapperBase Ownable |
| └ | _authorizeCheckSpenderManager | Internal 🔒 |   | onlyOwner |
| └ | _onlyRulesManager | Internal 🔒 |   | onlyOwner |
| └ | _msgSender | Internal 🔒 |   | |
| └ | _msgData | Internal 🔒 |   | |
| └ | _contextSuffixLength | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
