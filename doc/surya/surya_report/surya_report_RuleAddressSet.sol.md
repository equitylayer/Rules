## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/abstract/RuleAddressSet/RuleAddressSet.sol | d3c0ae66393dfd096ab093154e58ff19b4c8f5db |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleAddressSet** | Implementation | MetaTxModuleStandalone, RuleAddressSetInternal, RuleAddressSetInvariantStorage, IAddressList |||
| └ | <Constructor> | Public ❗️ | 🛑  | MetaTxModuleStandalone |
| └ | addAddresses | Public ❗️ | 🛑  | onlyAddressListAdd |
| └ | removeAddresses | Public ❗️ | 🛑  | onlyAddressListRemove |
| └ | addAddress | Public ❗️ | 🛑  | onlyAddressListAdd |
| └ | removeAddress | Public ❗️ | 🛑  | onlyAddressListRemove |
| └ | _authorizeAddressListAdd | Internal 🔒 |   | |
| └ | _authorizeAddressListRemove | Internal 🔒 |   | |
| └ | listedAddressCount | Public ❗️ |   |NO❗️ |
| └ | contains | Public ❗️ |   |NO❗️ |
| └ | isAddressListed | Public ❗️ |   |NO❗️ |
| └ | areAddressesListed | Public ❗️ |   |NO❗️ |
| └ | _msgSender | Internal 🔒 |   | |
| └ | _msgData | Internal 🔒 |   | |
| └ | _contextSuffixLength | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
