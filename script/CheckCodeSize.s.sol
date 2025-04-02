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
        myAdd = 0x3111d80ac22263D7637397a11Df5C99d0e78573D;
        myPK = 0x6fde03c9ba6e8cd06dfe7eba4bc608fbb4fc76ece307653a10294fd05084ed01;
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
                0x3111d80ac22263D7637397a11Df5C99d0e78573D
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
