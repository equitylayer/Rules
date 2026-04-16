## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/operation/RuleConditionalTransferLight.sol | 0296e0b6f9efba3f65c654982ee5e8b8b0d6b52c |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleConditionalTransferLight** | Implementation | AccessControlModuleStandalone, RuleConditionalTransferLightBase |||
| └ | <Constructor> | Public ❗️ | 🛑  | AccessControlModuleStandalone |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | _authorizeTransferApproval | Internal 🔒 |   | onlyRole |
| └ | _onlyComplianceManager | Internal 🔒 | 🛑  | onlyRole |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
