## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/operation/RuleConditionalTransferLight.sol | 7c57c9e1f11416f9c59b3bd81d6bab63ce7ba33d |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleConditionalTransferLight** | Implementation | AccessControl, RuleConditionalTransferLightInvariantStorage, IRule, ITransferContext |||
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | approveTransfer | Public ❗️ | 🛑  | onlyTransferApprover |
| └ | cancelTransferApproval | Public ❗️ | 🛑  | onlyTransferApprover |
| └ | approvedCount | Public ❗️ |   |NO❗️ |
| └ | transferred | Public ❗️ | 🛑  | onlyTransferExecutor |
| └ | transferred | Public ❗️ | 🛑  | onlyTransferExecutor |
| └ | detectTransferRestriction | Public ❗️ |   |NO❗️ |
| └ | _transferHash | Internal 🔒 |   | |
| └ | detectTransferRestrictionFrom | Public ❗️ |   |NO❗️ |
| └ | canReturnTransferRestrictionCode | External ❗️ |   |NO❗️ |
| └ | messageForTransferRestriction | External ❗️ |   |NO❗️ |
| └ | canTransfer | Public ❗️ |   |NO❗️ |
| └ | canTransferFrom | Public ❗️ |   |NO❗️ |
| └ | transferred | External ❗️ | 🛑  |NO❗️ |
| └ | _authorizeTransferApproval | Internal 🔒 | 🛑  | |
| └ | _authorizeTransferExecution | Internal 🔒 | 🛑  | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
