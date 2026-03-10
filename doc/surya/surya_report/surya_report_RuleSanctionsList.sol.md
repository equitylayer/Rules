## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/deployment/RuleSanctionsList.sol | 6d463c0d660ea2517d9aa0f678d0d38bb0634a1b |


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
