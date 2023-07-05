// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {IPool} from "aave-v3-core/contracts/interfaces/IPool.sol";

contract MiniSavingsAccount {

    // Data structure representing a yield generator
    struct YieldGenerator {
        address pool;
    }

    // Mapping of balances[address][token] => amount
    // This represent the deposited amount of a token for a specific address
    mapping (address => mapping(address => uint256)) public balances;
    mapping (address => YieldGenerator) public allowedTokens;

    constructor() {
        // Allow USDC token in the list of token allowed to deposit
        allowedTokens[0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48].pool = 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2;
    }

    function deposit(uint256 amount, address token) public {
        // Verify that the token is allowed
        require(allowedTokens[token].pool != address(0), "Token not allowed");
        balances[msg.sender][token] += amount;
        // Deposit the amount of the token to the specified Aave pool

    }

    function withdraw(uint256 amount, address token) public {
    }
}
