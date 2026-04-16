## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/deployment/RuleSpenderWhitelist.sol | fd6fa68104586756ba54f27a4ba950be852368ef |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleSpenderWhitelist** | Implementation | RuleSpenderWhitelistBase, AccessControlModuleStandalone |||
| └ | <Constructor> | Public ❗️ | 🛑  | RuleSpenderWhitelistBase AccessControlModuleStandalone |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | _authorizeAddressListAdd | Internal 🔒 |   | onlyRole |
| └ | _authorizeAddressListRemove | Internal 🔒 |   | onlyRole |
| └ | _msgSender | Internal 🔒 |   | |
| └ | _msgData | Internal 🔒 |   | |
| └ | _contextSuffixLength | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
