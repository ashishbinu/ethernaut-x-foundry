pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "../MagicNum/MagicNumFactory.sol";
import "../Ethernaut.sol";
import "./utils/vm.sol";
import "forge-std/console.sol";

contract MagicNumTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    Ethernaut ethernaut;

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
    }

    event log_bytes_(bytes32 value);

    function testMagicNum() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        MagicNumFactory magicNumFactory = new MagicNumFactory();
        ethernaut.registerLevel(magicNumFactory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(magicNumFactory);
        MagicNum ethernautMagicNum = MagicNum(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        // INIT CODE
        // PUSH1 0x0A
        // PUSH1 0x0C
        // PUSH1 0x00
        // CODECOPY
        // PUSH1 0x0A
        // PUSH1 0x00
        // RETURN

        // RUNTIME CODE
        // PUSH1 0x2a
        // PUSH1 0x00
        // MSTORE
        // PUSH1 0x20
        // PUSH1 0x00
        // RETURN
        bytes memory bytecode = hex"600a600c600039600a6000f3602a60005260206000f3";
        //                          --------init code------|---runtime code-----
        address contractAddress;
        assembly {
            contractAddress := create(0, add(bytecode, 0x20), mload(bytecode))
            if iszero(extcodesize(contractAddress)) { revert(0, 0) }
        }
        ethernautMagicNum.setSolver(contractAddress);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}
