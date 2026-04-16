## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/deployment/RuleERC2980.sol | 7d6e48bf6d899b27e31232a81f74fd04f19d6e76 |


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
