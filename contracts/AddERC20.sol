// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

/* 
@dev this is Degen DAO Token.
*/

contract CreateERC20 is ERC20 {

    constructor(string memory name_, string memory symbol_,uint256 totalSupply_) ERC20(name_, symbol_, totalSupply_) {
    }


}
