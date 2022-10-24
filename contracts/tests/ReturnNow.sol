// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ReturnNow {

    function returnNow() external view returns (uint256) {
       uint256 now_ = block.timestamp;
       return now_; 
    }
}
