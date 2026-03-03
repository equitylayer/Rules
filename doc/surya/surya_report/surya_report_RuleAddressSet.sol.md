## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/abstract/RuleAddressSet/RuleAddressSet.sol | f85924c631fcb2f7170ec5618808ab5b73252138 |


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
