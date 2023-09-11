// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract SecureSend {
    function sendFunds (address payable recipient, uint amount) public {
        //recipient.transfer(amount); // dangerous!
        require(recipient.send(amount), "Transfer failed"); // ok!
    }
}