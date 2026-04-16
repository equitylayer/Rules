// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

/**
 * @title IERC3643ComplianceFull
 * @dev Flat interface redeclaring the complete ERC-3643 ICompliance function set,
 *      including functions inherited by IERC3643Compliance from its parent interfaces
 *      (IERC3643ComplianceRead.canTransfer, IERC3643IComplianceContract.transferred).
 *
 *      Purpose: computing the correct ERC-165 interface ID for the full ERC-3643
 *      ICompliance interface via `type(IERC3643ComplianceFull).interfaceId`.
 *
 *      Background: `type(IFoo).interfaceId` only XORs selectors defined *directly* on
 *      `IFoo`, not those inherited from parent interfaces. Using `type(IERC3643Compliance).interfaceId`
 *      would therefore miss `canTransfer` and `transferred`.  This flat interface
 *      redeclares all eight functions so the XOR covers the full hierarchy.
 *
 *      Do NOT use this interface as a type annotation or for casting — use the actual
 *      `IERC3643Compliance` (from RuleEngine) for that.
 *
 *      Computed value: `type(IERC3643ComplianceFull).interfaceId == 0x3144991c`
 */
interface IERC3643ComplianceFull {
    // From IERC3643ComplianceRead
    function canTransfer(address from, address to, uint256 value) external view returns (bool isValid);
    // From IERC3643IComplianceContract
    function transferred(address from, address to, uint256 value) external;
    // From IERC3643Compliance (directly defined)
    function bindToken(address token) external;
    function unbindToken(address token) external;
    function isTokenBound(address token) external view returns (bool isBound);
    function getTokenBound() external view returns (address token);
    function created(address to, uint256 value) external;
    function destroyed(address from, uint256 value) external;
}
