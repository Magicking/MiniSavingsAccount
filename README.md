# MiniSavingsAccount

MiniSavingsAccount is a simple smart contract that allows you to deposit and withdraw funds and earn interest over a list of assets.

## Description

## Usages

 - Approve MiniSavingsAccount to spend your tokens

# Script Forge 

## Features

- Earn interest over multiple tokens that has a fiat representation
- [ ] USD
 - [ ] USDC
 - [ ] USDT
- EUR
 - [ ] agEUR
- GBP
- ...

- Money Market
 - [ ] Aave
 - [ ] ...

### Deposit

The deposit function allows you to deposit funds into the contract. The funds will be converted into an internal aacounting and will be added to the balance of the user.

### Withdraw

The withdraw function allows you to withdraw funds from the contract with the generated yield.

## Tests

## Documentation

- NatSpec

## Development notes

 - We start to developing first using the Aave Market and we will factor the logic to add at least one another yield generator.