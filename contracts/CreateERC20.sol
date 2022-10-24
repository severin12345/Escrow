// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

/* 
@dev this adds a new ERC20token. The constructor uses totalSupply_ as a parameter and will mint that as the
balance of the contract creator (msg.sender).
*/



contract CreateERC20 is ERC20 {

    constructor(string memory name_, string memory symbol_, uint256 totalSupply_) ERC20(name_, symbol_) {
        _mint(msg.sender, totalSupply_);
    }
}