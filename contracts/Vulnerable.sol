pragma solidity ^0.8.17;

contract Overflow {
    uint private sellerBalance=0;
    
    function add(uint value) public returns (bool){
        sellerBalance += value; // possible overflow

        // possible auditor assert
        // assert(sellerBalance >= value); 
    } 

    function safe_add(uint value) public returns (bool){
        require(value + sellerBalance >= sellerBalance);
        sellerBalance += value; 
    } 

    function vulnerableMethod() public {
        uint256 x = 2**256-1;
        uint256 y = x+1;
    }
}