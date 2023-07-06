// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/MiniSavingsAccount.sol";
import {IERC20} from "aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract MiniSavingsAccountScript is Script {
    MiniSavingsAccount msa;
    IERC20 usdc;
    address user;

    function setUp() public {
        // TODO: add the logic to deploy the MiniSavingsAccount contract
        msa = new MiniSavingsAccount();
        usdc = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
        user = msg.sender;
    }

    function run() public {
        uint256 amount = 1000 * 10**6;
        // Use this account to fund 0xcEe284F754E854890e311e3280b767F80797180d
        vm.prank(0xcEe284F754E854890e311e3280b767F80797180d);
        usdc.transfer(user, amount);
        vm.startPrank(user);
        usdc.approve(address(msa), amount);
        msa.deposit(amount, usdc);
        vm.stopPrank();
        console.log("msa.getBalance", msa.getBalance(user, usdc));
        console.log("msa.getAccruedBalance", msa.getAccruedBalance(user, usdc));
        // Error?
    }
}
