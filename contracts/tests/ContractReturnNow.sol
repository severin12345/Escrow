// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IReturnNow {
    function returnNow() external view returns (uint256);
}

contract ContractReturnNow {

    address returnNowAddress; 

    function setReturnNowAddress(address _returnNowAddress) public {
        returnNowAddress = _returnNowAddress;
        }
        
        function getNow() public view returns (uint256) {
            return IReturnNow(returnNowAddress).returnNow();
        }
}
