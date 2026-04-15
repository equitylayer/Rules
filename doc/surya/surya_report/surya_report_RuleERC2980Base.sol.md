## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./rules/validation/abstract/base/RuleERC2980Base.sol | 8cffbdad2d3c9179d43521bd57610ee8f3a47178 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **RuleERC2980Base** | Implementation | MetaTxModuleStandalone, RuleERC2980Internal, RuleERC2980InvariantStorage, RuleNFTAdapter, IERC2980, IIdentityRegistryVerified |||
| └ | <Constructor> | Public ❗️ | 🛑  | MetaTxModuleStandalone |
| └ | _authorizeWhitelistAdd | Internal 🔒 |   | |
| └ | _authorizeWhitelistRemove | Internal 🔒 |   | |
| └ | _authorizeFrozenlistAdd | Internal 🔒 |   | |
| └ | _authorizeFrozenlistRemove | Internal 🔒 |   | |
| └ | addWhitelistAddresses | Public ❗️ | 🛑  | onlyWhitelistAdd |
| └ | removeWhitelistAddresses | Public ❗️ | 🛑  | onlyWhitelistRemove |
| └ | addWhitelistAddress | Public ❗️ | 🛑  | onlyWhitelistAdd |
| └ | removeWhitelistAddress | Public ❗️ | 🛑  | onlyWhitelistRemove |
| └ | addFrozenlistAddresses | Public ❗️ | 🛑  | onlyFrozenlistAdd |
| └ | removeFrozenlistAddresses | Public ❗️ | 🛑  | onlyFrozenlistRemove |
| └ | addFrozenlistAddress | Public ❗️ | 🛑  | onlyFrozenlistAdd |
| └ | removeFrozenlistAddress | Public ❗️ | 🛑  | onlyFrozenlistRemove |
| └ | transferred | Public ❗️ |   |NO❗️ |
| └ | transferred | Public ❗️ |   |NO❗️ |
| └ | canReturnTransferRestrictionCode | Public ❗️ |   |NO❗️ |
| └ | messageForTransferRestriction | Public ❗️ |   |NO❗️ |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | whitelistAddressCount | Public ❗️ |   |NO❗️ |
| └ | isWhitelisted | Public ❗️ |   |NO❗️ |
| └ | whitelist | Public ❗️ |   |NO❗️ |
| └ | isVerified | Public ❗️ |   |NO❗️ |
| └ | areWhitelisted | Public ❗️ |   |NO❗️ |
| └ | frozenlistAddressCount | Public ❗️ |   |NO❗️ |
| └ | isFrozen | Public ❗️ |   |NO❗️ |
| └ | frozenlist | Public ❗️ |   |NO❗️ |
| └ | areFrozen | Public ❗️ |   |NO❗️ |
| └ | _detectTransferRestriction | Internal 🔒 |   | |
| └ | _detectTransferRestrictionFrom | Internal 🔒 |   | |
| └ | _transferred | Internal 🔒 |   | |
| └ | _transferredFrom | Internal 🔒 |   | |
| └ | _msgSender | Internal 🔒 |   | |
| └ | _msgData | Internal 🔒 |   | |
| └ | _contextSuffixLength | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
