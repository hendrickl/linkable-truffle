// Project : 0x751afF11CEDa4d298b817DF603d8F91Ce161fEA9
// Investor : 0x65c2c71FB6b78d07dc1Adc81ecdaC7983A5572D9
// contract deployed at 0x1cf33f3D53C92902C09dC1E27ac5C0BD7a62876D
// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;
pragma experimental ABIEncoderV2; 
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

    // Address of a project
    address public projectAddr;

    // Address of an investor
    address public investorAddr;

    // Price of a project
    uint public donation;
    
    constructor(address projectAddr_) payable {
        investorAddr = msg.sender;
        projectAddr = projectAddr_;
        donation = msg.value;
    }

    modifier onlyProject() {
        require(msg.sender == projectAddr, "Linkable : permission denied");
        _;
    }

    // Everyone can send ethers to contract
    receive() external payable {
        donation = donation.add(msg.value);
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
        uint256 amount_) public onlyProject {
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

    // Returns all demands
    function getAllDemand() public view returns (DemandFromProject[] memory) {
        return demands;
 }

}
