// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {IPool} from "aave-v3-core/contracts/interfaces/IPool.sol";
import {IERC20} from "aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract MiniSavingsAccount {

    // Data structure representing a yield generator
    struct YieldGenerator {
        address pool; // Aave specific pool address
        IERC20 yieldToken;
    }

    // Mapping of balances[address][token] => amount
    // This represent the deposited amount of a token for a specific address
    mapping (address => mapping(IERC20 => uint256)) public balances;
    mapping (IERC20 => YieldGenerator) public allowedTokens;
    mapping (IERC20 => uint256) public totalBalance;

    constructor() {
        // Allow USDC token in the list of token allowed to deposit
        // See https://docs.aave.com/developers/deployed-contracts/v3-mainnet/ethereum-mainnet
        IERC20 usdc = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
        allowedTokens[usdc].pool = 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2;
        allowedTokens[usdc].yieldToken = IERC20(0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c); // aToken USDC
    }

    function deposit(uint256 amount, IERC20 token) public {
        // Verify that the token is allowed
        require(allowedTokens[token].pool != address(0), "Token not allowed");
        balances[msg.sender][token] += amount;
        totalBalance[token] += amount;
        // Deposit the amount of the token to the specified Aave pool
        token.transferFrom(msg.sender, address(this), amount);
        IPool yieldPool = IPool(allowedTokens[token].pool);
        token.approve(address(yieldPool), amount);
        yieldPool.supply(address(token), amount, address(this), 0);
    }

    function getBalance(address user, IERC20 token) public view returns (uint256) {
        // TODO add the logic to get the balance of the user in the Aave pool
        return balances[user][token];
    }

    function getAccruedBalance(address user, IERC20 token) public view returns (uint256) {
        // TODO add the logic to get the balance of the user in the Aave pool
        // TODO Calculate the accrued balance for the specified user
        uint256 internalBalance = totalBalance[token] / getBalance(user, token);
        return allowedTokens[token].yieldToken.balanceOf(address(this)) / internalBalance;
    }

    function withdraw(uint256 amount, address token) public {
    }
}
