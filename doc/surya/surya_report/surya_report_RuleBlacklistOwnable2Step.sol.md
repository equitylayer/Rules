## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/deployment/RuleBlacklistOwnable2Step.sol | 52a9b745423b9706c4c88fc8aee35f4d5020c176 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleBlacklistOwnable2Step** | Implementation | RuleBlacklistBase, Ownable2Step |||
| └ | <Constructor> | Public ❗️ | 🛑  | RuleBlacklistBase Ownable |
| └ | _authorizeAddressListAdd | Internal 🔒 |   | onlyOwner |
| └ | _authorizeAddressListRemove | Internal 🔒 |   | onlyOwner |
| └ | _msgSender | Internal 🔒 |   | |
| └ | _msgData | Internal 🔒 |   | |
| └ | _contextSuffixLength | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
