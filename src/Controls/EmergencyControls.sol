// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Ownership.sol";

contract EmergencyControls is Ownership {

    bool public paused;

    modifier whenNotPaused() {
        require(!paused, "paused");
        _;
    }

    modifier whenPaused() {
        require(paused, "not paused");
        _;
    }

    function pause() external onlyOwner {
        paused = true;
    }

    function unpause() external onlyOwner {
        paused = false;
    }

    function emergencyWithdrawAll(address payable to)
        external
        onlyOwner
        whenPaused
    {
        uint256 balance = address(this).balance;

        (bool success,) = to.call{value: balance}("");
        require(success);
    }
}