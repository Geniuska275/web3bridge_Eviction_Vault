// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IEvictionVault {
    // Deposit ETH into the vault
    function deposit() external payable;

    // Withdraw ETH from the vault
    function withdraw(uint256 amount) external;

    // Emergency withdraw for admin/owner
    function emergencyWithdrawAll(address payable to) external;

    // Pause/unpause the vault
    function pause() external;
    function unpause() external;

    // Set the Merkle root for claim verification
    function setMerkleRoot(bytes32 newRoot) external;

    // Query balance of a user
    function balances(address user) external view returns (uint256);

    // Check if the contract is paused
    function paused() external view returns (bool);
}