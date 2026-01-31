// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GasHeavyVault {
    address[] public users;
    mapping(address => uint256) public balances;

    function deposit() external payable {
        if (balances[msg.sender] == 0) {
            users.push(msg.sender);
        }
        balances[msg.sender] += msg.value;
    }

    function distributeRewards() external {
        require(users.length > 0, "No users");

        for (uint256 i = 0; i < users.length; i++) {
            address user = users[i];
            balances[user] += 1 ether;
        }
    }

    function withdraw() external {
        require(balances[msg.sender] > 0, "No balance");

        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
