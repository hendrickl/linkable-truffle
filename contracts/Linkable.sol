// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;
import "@openzeppelin/contracts/math/SafeMath.sol";

contract Linkable {
    using SafeMath for uint256;

    // A struct for the projectAddr request
    struct DemandFromProject {
        string name;
        string creator;
        string description;
        string location;
        uint256 amount;
        bool paid;
    }
    // Array of demands
    DemandFromProject[] public demands;
    
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

    modifier onlyCreator() {
        require(msg.sender == creatorAddr, "Linkable : permission denied");
        _;
    }

    // Everyone can send ethers to contract
    receive() external payable {
        cost = cost.add(msg.value);
    }

    // getBalance() returns the balance of an address
    function getBalance(address addr_) public view returns (uint256) {
        return address(addr_).balance;
    }
    
    // createDemand() creates demand and adds them in the demands array
    function createDemand(
        string memory name_,
        string memory creator_,
        string memory description_,
        string memory location_,
        uint256 amount_) public onlyCreator {
        DemandFromProject memory demand = DemandFromProject({
            name: name_,
            creator: creator_,
            description: description_,
            location: location_,
            amount: amount_,
            paid: false
        });

        demands.push(demand);
    }

}
