// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract SecureContract {
    mapping(address => bool) private withdrawalLocks;
    uint public balance;

    function deposit() public payable {
        balance += msg.value;
    }

    function withdraw(uint amount) public {
        require(balance >= amount, "Insufficient balance");

        // Ensure the sender's withdrawal is not locked
        require(!withdrawalLocks[msg.sender], "Withdrawal is locked");
        
        // Lock the withdrawal for the sender
        withdrawalLocks[msg.sender] = true;

        // Perform the transfer
        balance -= amount;
        address payable recipient = payable(msg.sender);
        recipient.transfer(amount);

        // Unlock the withdrawal for the sender
        withdrawalLocks[msg.sender] = false;
    }
}
