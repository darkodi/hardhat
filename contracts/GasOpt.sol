// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Gas_opt {
    uint public total; // state var - stored on the blockchain


    // [1,2,3,4,5,6,7,8,9,10,53,55,76,32,100,400,500]


    function sumOfEvenNumbers(uint[] calldata nums) external {
        uint _total;
        uint arrLength = nums.length;
        for (uint i = 0; i < arrLength; ++i) 
        {
            //bool isEven = nums[i] % 2 == 0;
            //bool isLessThan99 = nums[i] < 99;
            uint n = nums[i];
            if(n % 2 == 0 && n < 99) {
                _total += n;
            }
        }
        total = _total;
    }
    // start 40062 gas - execution cost
    
    // 1. calldate instead of memory
    // 35837 gas - execution cost
    // 2. use local var for calculation instead of state var
    // 34531 gas
    // 3. short-circuit - remove bools
    // 33711 gas 
    // 4. loop increment (++i)
    // 32657 gas
    // 5. cache the length of array
    // 32526 gas
    // 6. var for nums[i]
    // 31931 gas 

}





