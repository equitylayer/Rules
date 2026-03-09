## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/deployment/RuleERC2980Ownable2Step.sol | 9aa2fe60b1c93ee6bbeee4f84642e0a7662bc6c5 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleERC2980Ownable2Step** | Implementation | RuleERC2980Base, Ownable2Step |||
| └ | <Constructor> | Public ❗️ | 🛑  | RuleERC2980Base Ownable |
| └ | _authorizeWhitelistAdd | Internal 🔒 |   | onlyOwner |
| └ | _authorizeWhitelistRemove | Internal 🔒 |   | onlyOwner |
| └ | _authorizeFrozenlistAdd | Internal 🔒 |   | onlyOwner |
| └ | _authorizeFrozenlistRemove | Internal 🔒 |   | onlyOwner |
| └ | _msgSender | Internal 🔒 |   | |
| └ | _msgData | Internal 🔒 |   | |
| └ | _contextSuffixLength | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
