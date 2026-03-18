// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import {Ownable} from "OZ/access/Ownable.sol";
import {Ownable2Step} from "OZ/access/Ownable2Step.sol";
import {Context} from "OZ/utils/Context.sol";
import {ERC2771Context} from "../../../modules/MetaTxModuleStandalone.sol";
import {RuleSanctionsListBase} from "../abstract/base/RuleSanctionsListBase.sol";
import {ISanctionsList} from "../../interfaces/ISanctionsList.sol";

/**
 * @title RuleSanctionsListOwnable2Step
 * @notice Ownable2Step variant of RuleSanctionsList.
 */
contract RuleSanctionsListOwnable2Step is RuleSanctionsListBase, Ownable2Step {
    /*//////////////////////////////////////////////////////////////
                             CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address owner, address forwarderIrrevocable, ISanctionsList sanctionContractOracle_)
        RuleSanctionsListBase(forwarderIrrevocable, sanctionContractOracle_)
        Ownable(owner)
    {}

    /*//////////////////////////////////////////////////////////////
                            ACCESS CONTROL
    //////////////////////////////////////////////////////////////*/

    function _authorizeSanctionListManager() internal view virtual override onlyOwner {}

    /*//////////////////////////////////////////////////////////////
                        INTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function _msgSender() internal view virtual override(ERC2771Context, Context) returns (address sender) {
        return ERC2771Context._msgSender();
    }

    function _msgData() internal view virtual override(ERC2771Context, Context) returns (bytes calldata) {
        return ERC2771Context._msgData();
    }

    function _contextSuffixLength() internal view virtual override(ERC2771Context, Context) returns (uint256) {
        return ERC2771Context._contextSuffixLength();
    }
}
