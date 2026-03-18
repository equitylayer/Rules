// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {AccessControlEnumerable} from "OZ/access/extensions/AccessControlEnumerable.sol";
import {AccessControlModuleStandalone} from "../../../modules/AccessControlModuleStandalone.sol";
import {RuleIdentityRegistryBase} from "../abstract/base/RuleIdentityRegistryBase.sol";
import {RuleTransferValidation} from "../abstract/core/RuleTransferValidation.sol";

/**
 * @title RuleIdentityRegistry
 * @notice Checks the ERC-3643 Identity Registry for transfer participants when configured.
 * @dev Burns (to == address(0)) are allowed even if the sender is not verified.
 */
contract RuleIdentityRegistry is AccessControlModuleStandalone, RuleIdentityRegistryBase {
    /*//////////////////////////////////////////////////////////////
                             CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address admin, address identityRegistry_)
        AccessControlModuleStandalone(admin)
        RuleIdentityRegistryBase(identityRegistry_)
    {}

    /*//////////////////////////////////////////////////////////////
                          PUBLIC FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControlEnumerable, RuleTransferValidation)
        returns (bool)
    {
        return AccessControlEnumerable.supportsInterface(interfaceId)
            || RuleTransferValidation.supportsInterface(interfaceId);
    }

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    function _authorizeIdentityRegistryManager() internal view virtual override onlyRole(DEFAULT_ADMIN_ROLE) {}
}
