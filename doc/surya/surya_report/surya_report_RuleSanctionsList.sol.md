## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/deployment/RuleSanctionsList.sol | 8b9a8d5f53a59eccc4ac0204eeab3857cd8e18c4 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleSanctionsList** | Implementation | AccessControlModuleStandalone, RuleSanctionsListBase |||
| └ | <Constructor> | Public ❗️ | 🛑  | AccessControlModuleStandalone RuleSanctionsListBase |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | _authorizeSanctionListManager | Internal 🔒 |   | onlyRole |
| └ | _msgSender | Internal 🔒 |   | |
| └ | _msgData | Internal 🔒 |   | |
| └ | _contextSuffixLength | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
