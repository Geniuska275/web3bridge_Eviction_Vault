// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract Ownership {

    address private _owner;

    event OwnershipTransferred(address oldOwner, address newOwner);

    modifier onlyOwner() {
        require(msg.sender == _owner, "not owner");
        _;
    }

    function owner() public view returns(address) {
        return _owner;
    }

    function _setOwner(address newOwner) internal {
        _owner = newOwner;
        emit OwnershipTransferred(address(0), newOwner);
    }
}