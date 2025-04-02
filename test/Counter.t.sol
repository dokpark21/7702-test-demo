// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test, Vm, console} from "forge-std/Test.sol";
import {Delegation} from "../src/Delegation.sol";

contract CounterTest is Test {
    Delegation public delegation;
    address public Alice;
    uint256 public AlicePK;
    uint256 public codeSizeAfter;

    function setUp() public {
        delegation = new Delegation();
        (Alice, AlicePK) = makeAddrAndKey("Alice");
    }

    function test_code_size() public {
        vm.deal(Alice, 1 ether);

        vm.startPrank(Alice);

        Vm.SignedDelegation memory signDelegation = vm.signDelegation(
            address(delegation),
            AlicePK
        );

        vm.attachDelegation(signDelegation);

        uint256 codeSizeBefore;
        address alice = Alice;

        assembly {
            codeSizeBefore := extcodesize(alice)
        }

        console.log("Alice code size before run: ", codeSizeBefore);

        (, bytes memory data) = Alice.call(
            abi.encodeWithSignature("checkCodeSize(address)", Alice)
        );

        codeSizeAfter = abi.decode(data, (uint256));

        console.log("Alice code size in run: ", codeSizeAfter);
    }
}
