// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

/* 
@dev this is a contract to interact with any ERC20 Token based on the IERC20 interface. 
*/

contract InteractERC20 {

    address _ERC20Address;

    constructor(address ERC20Address_) {
        _ERC20Address = ERC20Address_;
    }

    function getBalanceOf(address _account) external view returns (uint256) {
        return IERC20(_ERC20Address).balanceOf(_account);
    }
}
