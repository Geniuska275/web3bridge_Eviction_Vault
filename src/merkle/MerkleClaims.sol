// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "../Controls/Ownership.sol";

contract MerkleClaims is Ownership {

    bytes32 public merkleRoot;

    mapping(address => bool) public claimed;

    function setMerkleRoot(bytes32 newRoot)
        external
        onlyOwner
    {
        merkleRoot = newRoot;
    }

    function verifyClaim(
        address user,
        uint256 amount,
        bytes32[] calldata proof
    )
        public
        view
        returns(bool)
    {
        bytes32 leaf = keccak256(abi.encode(user, amount));

        return MerkleProof.verify(proof, merkleRoot, leaf);
    }
}