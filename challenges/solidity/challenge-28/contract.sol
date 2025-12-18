// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract Vault {
    address public immutable owner;
    mapping(address => uint256) payment;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner can access");
        _;
    }
    function deposit() external payable {
        payment[msg.sender] += msg.value;
    }
    function withdraw(uint value) external {
        if (payment[msg.sender] <= value) revert("insufficient balance");
        payment[msg.sender] -= value;

        // take 5% from the user
        uint256 collect = (value * 5) / 100;
        value -= collect;

        payment[owner] += collect;
        payable(msg.sender).transfer(value);
    }
    function checkBalance() external view returns (uint256) {
        return payment[msg.sender];
    }

    function collectFee() external onlyOwner {
        if (payment[msg.sender] <= 0) revert("insufficient balance");

        payable(msg.sender).transfer(address(this).balance);
    }
}
