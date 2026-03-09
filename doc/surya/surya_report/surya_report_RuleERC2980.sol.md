## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/deployment/RuleERC2980.sol | b87580207068c728624349e0453fee91c3b90605 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleERC2980** | Implementation | RuleERC2980Base, AccessControlModuleStandalone |||
| └ | <Constructor> | Public ❗️ | 🛑  | RuleERC2980Base AccessControlModuleStandalone |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | _authorizeWhitelistAdd | Internal 🔒 |   | onlyRole |
| └ | _authorizeWhitelistRemove | Internal 🔒 |   | onlyRole |
| └ | _authorizeFrozenlistAdd | Internal 🔒 |   | onlyRole |
| └ | _authorizeFrozenlistRemove | Internal 🔒 |   | onlyRole |
| └ | _msgSender | Internal 🔒 |   | |
| └ | _msgData | Internal 🔒 |   | |
| └ | _contextSuffixLength | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
