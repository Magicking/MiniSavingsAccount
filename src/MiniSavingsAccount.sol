// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract MiniSavingsAccount {
    // Mapping of balances[address][token] => amount
    // This represent the deposited amount of a token for a specific address
    mapping (address => mapping(address => uint256)) public balances;
    mapping (address => bool) public allowedTokens;

    constructor() {
        // Allow USDC token in the list of token allowed to deposit
        allowedTokens[0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48] = true;
    }

    function deposit(uint256 amount, address token) public {
        // Verify that the token is allowed
        require(allowedTokens[token], "Token not allowed");
        balances[msg.sender][token] += amount;
        // Deposit the amount of the token to the specified Aave pool

    }

    function withdraw(uint256 amount, address token) public {
    }
}
