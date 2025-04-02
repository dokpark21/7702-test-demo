// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Delegation {
    function checkCodeSize(address _addr) public view returns (uint256) {
        uint256 size;
        assembly {
            size := extcodesize(_addr)
        }
        return size;
    }
}
