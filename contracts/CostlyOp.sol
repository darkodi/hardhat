// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
// this is code with 0 slither warnings

contract CostlyOp {

    //uint loopCount = 100;
    uint sv = 0;
    function test () external {
        uint local = 0;
       for (uint i = 0; i < 100; i++) {
            local++;
       }
       sv = local;
    }
}