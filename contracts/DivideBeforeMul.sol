// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract DivBeforeMul {

    
    uint public res = 0;
    function test (uint x, uint y) public {
        res = x / y * y; // Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#divide-before-multiply
    }
}