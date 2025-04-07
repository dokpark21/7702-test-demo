// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {Vm} from "forge-std/Vm.sol";
import {Delegation} from "../src/Delegation.sol";

contract CheckCodeSize is Script {
    Delegation public delegation;
    address public myAdd;
    uint256 public myPK;

    function setUp() public {
        delegation = new Delegation();
        myAdd = /** addr */;
        myPK = /** pv key*/;
    }

    function run() public {
        vm.startBroadcast(myPK);

        Vm.SignedDelegation memory signedDelegation = vm.signDelegation(
            address(delegation),
            myPK
        );

        vm.attachDelegation(signedDelegation);

        uint256 codeSizeBefore;

        assembly {
            codeSizeBefore := extcodesize(
                /** addr */
            )
        }

        (, bytes memory data) = myAdd.call(
            abi.encodeWithSignature("checkCodeSize(address)", myAdd)
        );

        uint256 codeSizeAfter = abi.decode(data, (uint256));
        console.log("Alice code size before run: ", codeSizeBefore);
        console.log("Alice code size in run: ", codeSizeAfter);

        vm.stopBroadcast();
    }
}
