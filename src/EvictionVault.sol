// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Controls/EmergencyControls.sol";
import "./merkle/MerkleClaims.sol";

contract EvictionVault is EmergencyControls, MerkleClaims {

    mapping(address => uint256) public balances;

    constructor() {
        _setOwner(msg.sender);
    }

    receive() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount)
        external
        whenNotPaused
    {
        require(balances[msg.sender] >= amount);

        balances[msg.sender] -= amount;

        (bool success,) = msg.sender.call{value: amount}("");
        require(success);
    }

    function claim(
        uint256 amount,
        bytes32[] calldata proof
    )
        external
        whenNotPaused
    {
        require(!claimed[msg.sender]);

        require(
            verifyClaim(msg.sender, amount, proof),
            "invalid proof"
        );

        claimed[msg.sender] = true;

        (bool success,) = msg.sender.call{value: amount}("");
        require(success);
    }
}