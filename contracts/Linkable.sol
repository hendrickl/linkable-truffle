// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;
import "@openzeppelin/contracts/math/SafeMath.sol";

contract Linkable {
    using SafeMath for uint256;
    
    // Address of a creator
    address public creatorAddr;

    // Address of a project
    address public projectAddr;

    // Address of an investor
    address public investorAddr;

    // Price of a project
    uint public cost;
    
    constructor(address projectAddr_) payable {
        creatorAddr = msg.sender;
        projectAddr = projectAddr_;
        cost = msg.value;
    }

    // Everyone can send ethers to contract
    receive() external payable {
        cost = cost.add(msg.value);
    }
    
}
