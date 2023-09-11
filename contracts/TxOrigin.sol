// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract VulnerableAuction {

    address payable owner;

    constructor() public {
        owner = payable(tx.origin);
    }
    function transferOwnership (address payable newOwner) public {
       require (tx.origin == owner, "Error");
       owner = newOwner;
    }
    function withdrawFunds () public {
       require (tx.origin == owner, "Error");
       payable(msg.sender).transfer(address(this).balance);
    }
}