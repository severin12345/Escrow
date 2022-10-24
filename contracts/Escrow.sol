// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract Escrow {

    //TODO include ETH as trading pair
    //bool tokenAIsETH;
    //bool tokenBIsETH;

    address public tokenAAddress;
    address public tokenBAddress;

    address public userA;
    address public userB;

    uint256 public tokenAAmount;
    uint256 public tokenBAmount;

    uint256 public escrowEnd;

    bool AHasDeposited;
    bool BHasDeposited;

    event DepositA(address tokenAddress, uint256 _amount);
    event DepositB(address tokenAddress, uint256 _amount);
    event Payout(address tokenAAddress, uint256 tokenAAmount, address tokenBAddress, uint tokenBAmount);
    event Withdrawal(address tokenAAddress, uint256 tokenAAmount, address tokenBAddress, uint tokenBAmount);

    constructor(
        address tokenAAddress_,
        address tokenBAddress_,
        //address userA_,
        address userB_,
        uint256 tokenAAmount_,
        uint256 tokenBAmount_,
        uint256 escrowEnd_
    ) {
        tokenAAddress = tokenAAddress_;
        tokenBAddress = tokenBAddress_;
        userA = msg.sender;
        userB = userB_;
        tokenAAmount = tokenAAmount_;
        tokenAAmount = tokenAAmount_;
        tokenBAmount = tokenBAmount_;
        escrowEnd = escrowEnd_;
    }

    modifier escrowActive() {
        require(block.timestamp <= escrowEnd);
        _;
    }
    
    function depositA() external escrowActive returns (bool) {
        require(msg.sender == userA,"msg.sender is not user A");
        uint256 _userAAllowance = IERC20(tokenAAddress).allowance(userA, address(this));
        require(_userAAllowance >= tokenAAmount, "Allowance too low");
        IERC20(tokenAAddress).transferFrom(userA, address(this), tokenAAmount);
        emit DepositA(tokenAAddress, tokenAAmount);
        AHasDeposited = true;
        return AHasDeposited;
    }

    function depositB() external escrowActive returns (bool) {
        require(msg.sender == userB,"msg.sender is not user B");
        uint256 _userBAllowance = IERC20(tokenBAddress).allowance(userB, address(this));
        require(_userBAllowance >= tokenBAmount, "Allowance too low");
        IERC20(tokenBAddress).transferFrom(userB, address(this), tokenBAmount);
        emit DepositB(tokenBAddress, tokenBAmount);
        BHasDeposited = true;
        return BHasDeposited;
    }
    function payout() external escrowActive {
        require(AHasDeposited == true, "User A has not yet deposited");
        require(BHasDeposited == true, "User B has not yet deposited");
        IERC20(tokenAAddress).transfer(userB, tokenAAmount);
        IERC20(tokenBAddress).transfer(userA, tokenBAmount);
        emit Payout(tokenAAddress, tokenAAmount, tokenBAddress, tokenBAmount);
    }

    function withdraw() external {
        require(msg.sender == userA || msg.sender == userB, "msg.sender is not user A or user B");
        if(AHasDeposited == true && BHasDeposited == true) {
            IERC20(tokenAAddress).transfer(userA, tokenAAmount);
            IERC20(tokenBAddress).transfer(userB, tokenBAmount);
            AHasDeposited = false;
            BHasDeposited = false;
            emit Withdrawal(tokenAAddress, tokenAAmount, tokenBAddress, tokenBAmount);
        }
        else if(AHasDeposited == true) {
            IERC20(tokenAAddress).transfer(userA, tokenAAmount);
            AHasDeposited = false;
            emit Withdrawal(tokenAAddress, tokenAAmount, tokenBAddress, 0);
        }
        else if(BHasDeposited == true) {
            IERC20(tokenBAddress).transfer(userB, tokenBAmount);
            BHasDeposited = false;
            emit Withdrawal(tokenAAddress, 0, tokenBAddress, tokenBAmount);
        }
    }
}
