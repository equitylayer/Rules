// SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

/* ==== CMTAT === */
import {IERC1404, IERC1404Extend} from "CMTAT/interfaces/tokenization/draft-IERC1404.sol";
import {IERC3643ComplianceRead} from "CMTAT/interfaces/tokenization/IERC3643Partial.sol";
import {IERC7551Compliance} from "CMTAT/interfaces/tokenization/draft-IERC7551.sol";
/* ==== RuleEngine === */
import {IRule} from "RuleEngine/interfaces/IRule.sol";
import {RuleInterfaceId} from "RuleEngine/modules/library/RuleInterfaceId.sol";

abstract contract RuleValidateTransfer is IERC1404Extend, IERC3643ComplianceRead, IERC7551Compliance, IRule {
    /**
     * @notice Internal transfer restriction check.
     * @param from the origin address
     * @param to the destination address
     * @param value amount to transfer
     * @return restrictionCode The restriction code for this rule.
     */
    function _detectTransferRestriction(address from, address to, uint256 value)
        internal
        view
        virtual
        returns (uint8 restrictionCode);

    /**
     * @notice Internal transfer restriction check for spender-initiated transfers.
     * @param spender the caller executing the transfer
     * @param from the origin address
     * @param to the destination address
     * @param value amount to transfer
     * @return restrictionCode The restriction code for this rule.
     */
    function _detectTransferRestrictionFrom(address spender, address from, address to, uint256 value)
        internal
        view
        virtual
        returns (uint8 restrictionCode);

    /**
     * @inheritdoc IERC1404
     */
    function detectTransferRestriction(address from, address to, uint256 value)
        public
        view
        virtual
        override(IERC1404)
        returns (uint8)
    {
        return _detectTransferRestriction(from, to, value);
    }

    /**
     * @inheritdoc IERC1404Extend
     */
    function detectTransferRestrictionFrom(address spender, address from, address to, uint256 value)
        public
        view
        virtual
        override(IERC1404Extend)
        returns (uint8)
    {
        return _detectTransferRestrictionFrom(spender, from, to, value);
    }

    /**
     * @notice Validate a transfer
     * @param from the origin address
     * @param to the destination address
     * @param amount to transfer
     * @return isValid => true if the transfer is valid, false otherwise
     *
     */
    function canTransfer(address from, address to, uint256 amount)
        public
        view
        override(IERC3643ComplianceRead)
        returns (bool isValid)
    {
        return _detectTransferRestriction(from, to, amount) == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
    }

    /**
     * @inheritdoc IERC7551Compliance
     */
    function canTransferFrom(address spender, address from, address to, uint256 value)
        public
        view
        virtual
        override(IERC7551Compliance)
        returns (bool)
    {
        return _detectTransferRestrictionFrom(spender, from, to, value)
            == uint8(IERC1404Extend.REJECTED_CODE_BASE.TRANSFER_OK);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
        return interfaceId == type(IRule).interfaceId || interfaceId == RuleInterfaceId.IRULE_INTERFACE_ID;
    }
}
