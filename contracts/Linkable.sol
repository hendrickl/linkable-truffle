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
        bool blocked;
        bool paid;
    }
    // Array of demands
    DemandFromProject[] public demands;

    // Address of a project
    address payable public projectAddr;

    // Address of an investor
    address payable public investorAddr;

    // fund from investor
    uint256 public fund;

    constructor() payable {
        investorAddr = payable(0x65c2c71FB6b78d07dc1Adc81ecdaC7983A5572D9);
        projectAddr = payable(0x751afF11CEDa4d298b817DF603d8F91Ce161fEA9);
        fund = msg.value;
    }

    modifier onlyProject() {
        require(msg.sender == projectAddr, "Linkable : permission denied");
        _;
    }

    modifier onlyInvestor() {
        require(msg.sender == investorAddr, "Linkable : permission denied");
        _;
    }

    // Everyone can send ethers to contract
    receive() external payable {
        fund = fund.add(msg.value);
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
        uint256 amount_
    ) public onlyProject {
        DemandFromProject memory demand =
            DemandFromProject({
                name: name_,
                creator: creator_,
                description: description_,
                location: location_,
                amount: amount_,
                blocked: true,
                paid: false
            });

        demands.push(demand);

        emit DemandCreated(name_, creator_, description_, location_, amount_, demand.blocked, demand.paid);
    }

    // Emited when createDemand is called
    event DemandCreated(
        string name,
        string creator,
        string description,
        string location,
        uint256 amount,
        bool blocked,
        bool paid
    );

    // Returns all DemandFormProject items
    function getAllDemand() public view returns (DemandFromProject[] memory) {
        return demands;
    }

    // Returns the blocked property false with some checks
    function unBlock(uint256 i_) public onlyInvestor {
        DemandFromProject storage demand = demands[i_];
        demand.blocked = false;

        emit unBlockedDemand(demand.blocked);
    }

    // Emited when unBlock is called
    event unBlockedDemand(bool blocked);

    // Transfer the funds to projectAddr
    function withdraw(uint256 i_) public onlyProject {
        DemandFromProject storage demand = demands[i_];
        require(!demand.blocked, "Linkable : permission denied");
        require(!demand.paid, "Linkable : demand already paid");
        projectAddr.transfer(demand.amount);
        demand.paid = true;

        emit demandPaid(projectAddr, demand.amount);
    }

    // Emited when withdraw is called
    event demandPaid(address recipient_, uint256 amount_);
}
