// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;

contract Linkable {
    
    struct Project {
        string name;
        string description;
        uint256 amount;
        string location;
        bool raised;
    }

    enum Status {PENDING, ACCEPTED, REJECTED, CANCELED}

    Project[] public projects;

    address payable public creator;
    address payable public investor;
    uint256 public cost;
    uint256 public raisingMoney;
    Status public status;

    constructor(
        address payable _creator,
        address payable _investor,
        uint256 _cost
    ) {
        status = Status.PENDING;
        creator = _creator;
        investor = _investor;
        cost = _cost;
        raisingMoney = _cost;
    }
    
    function register(
        string memory name_,
        string memory desc_,
        uint256 amount_,
        string memory loc_
    ) public {
        // It updates the struct Project
        Project memory project = Project({
            name : name_,
            description : desc_,
            amount : amount_,
            location : loc_,
            raised : false
        });

        projects.push(project);

        emit Projectregistered(name_, desc_, amount_, loc_, project.raised);
    }

    event Projectregistered(string name, string description, uint256 amount, string location, bool raised);
}
