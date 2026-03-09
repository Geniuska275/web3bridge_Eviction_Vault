// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/EvictionVault.sol";

contract DeployEvictionVault is Script {
    EvictionVault public vault;

    function run() external {
        // Start broadcasting to a network
        vm.startBroadcast();

        // Deploy the EvictionVault contract
        vault = new EvictionVault();

        bytes32 initialMerkleRoot = 0x0; // replace with actual root
        vault.setMerkleRoot(initialMerkleRoot);

        // Log deployed address
        console.log("EvictionVault deployed at:", address(vault));

        vm.stopBroadcast();
    }
}