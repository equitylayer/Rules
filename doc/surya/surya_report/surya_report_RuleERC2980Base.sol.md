## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/abstract/base/RuleERC2980Base.sol | a48f4f0ab9e21d1da777c6000ef780c527ae0110 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleERC2980Base** | Implementation | MetaTxModuleStandalone, RuleERC2980Internal, RuleERC2980InvariantStorage, RuleNFTAdapter, IERC2980, IIdentityRegistryVerified |||
| └ | <Constructor> | Public ❗️ | 🛑  | MetaTxModuleStandalone |
| └ | _detectTransferRestriction | Internal 🔒 |   | |
| └ | _detectTransferRestrictionFrom | Internal 🔒 |   | |
| └ | transferred | Public ❗️ |   |NO❗️ |
| └ | transferred | Public ❗️ |   |NO❗️ |
| └ | _transferred | Internal 🔒 |   | |
| └ | _transferredFrom | Internal 🔒 |   | |
| └ | canReturnTransferRestrictionCode | Public ❗️ |   |NO❗️ |
| └ | messageForTransferRestriction | Public ❗️ |   |NO❗️ |
| └ | addWhitelistAddresses | Public ❗️ | 🛑  | onlyWhitelistAdd |
| └ | removeWhitelistAddresses | Public ❗️ | 🛑  | onlyWhitelistRemove |
| └ | addWhitelistAddress | Public ❗️ | 🛑  | onlyWhitelistAdd |
| └ | removeWhitelistAddress | Public ❗️ | 🛑  | onlyWhitelistRemove |
| └ | whitelistAddressCount | Public ❗️ |   |NO❗️ |
| └ | isWhitelisted | Public ❗️ |   |NO❗️ |
| └ | whitelist | Public ❗️ |   |NO❗️ |
| └ | isVerified | Public ❗️ |   |NO❗️ |
| └ | areWhitelisted | Public ❗️ |   |NO❗️ |
| └ | addFrozenlistAddresses | Public ❗️ | 🛑  | onlyFrozenlistAdd |
| └ | removeFrozenlistAddresses | Public ❗️ | 🛑  | onlyFrozenlistRemove |
| └ | addFrozenlistAddress | Public ❗️ | 🛑  | onlyFrozenlistAdd |
| └ | removeFrozenlistAddress | Public ❗️ | 🛑  | onlyFrozenlistRemove |
| └ | frozenlistAddressCount | Public ❗️ |   |NO❗️ |
| └ | isFrozen | Public ❗️ |   |NO❗️ |
| └ | frozenlist | Public ❗️ |   |NO❗️ |
| └ | areFrozen | Public ❗️ |   |NO❗️ |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | _authorizeWhitelistAdd | Internal 🔒 |   | |
| └ | _authorizeWhitelistRemove | Internal 🔒 |   | |
| └ | _authorizeFrozenlistAdd | Internal 🔒 |   | |
| └ | _authorizeFrozenlistRemove | Internal 🔒 |   | |
| └ | _msgSender | Internal 🔒 |   | |
| └ | _msgData | Internal 🔒 |   | |
| └ | _contextSuffixLength | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
