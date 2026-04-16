## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/operation/abstract/RuleConditionalTransferLightApprovalBase.sol | 6aa6f8cfabdb795343debc1b501508f392428404 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleConditionalTransferLightApprovalBase** | Implementation | RuleConditionalTransferLightInvariantStorage |||
| └ | _authorizeTransferApproval | Internal 🔒 |   | |
| └ | _authorizeTransferExecution | Internal 🔒 |   | |
| └ | transferred | External ❗️ | 🛑  | onlyTransferExecutor |
| └ | approveTransfer | Public ❗️ | 🛑  | onlyTransferApprover |
| └ | cancelTransferApproval | Public ❗️ | 🛑  | onlyTransferApprover |
| └ | approvedCount | Public ❗️ |   |NO❗️ |
| └ | _transferredFromContext | Internal 🔒 | 🛑  | |
| └ | _transferred | Internal 🔒 | 🛑  | |
| └ | _transferHash | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
