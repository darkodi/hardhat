// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract VulnerableAuction { // Slither cannot catch this vuln

    
    uint public highestBid;
    address public highestBidder;
    function bid (uint amount) public {
       require (amount > highestBid, "Error");
       highestBid = amount;
       highestBidder = msg.sender;
    }
}