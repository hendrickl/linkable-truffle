// Project 1 : 0x751afF11CEDa4d298b817DF603d8F91Ce161fEA9
// Creator 1 : 0x1F4FDad26cfe9636ADB5595A3814A25e892A9326
// Investor 1 : 0x65c2c71FB6b78d07dc1Adc81ecdaC7983A5572D9

// Project 2 : 0x2c193bEd719BAb52866425dA893eFeDE8Eda42aD
// Creator 2 : 0xF034a2AA883D2909AF9B3c7406ed01d6a2dF80ca
// Investor 2 : 0x17F39400205271545072f13f8c16d81250fE0606

// Project 3 : 0x22bBc390fC1EFe352371456002F69fDF0481CD03
// Creator 3 : 0x6C97b80D51F0d13744419c48a9045456c82f14dA
// Investor 3 : 0x0D2fbF2F196f5895A90eA3Ba24bAD8aE86EfA2f9

// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;
pragma experimental ABIEncoderV2;
import "@openzeppelin/contracts/math/SafeMath.sol";

contract Linkable {
    using SafeMath for uint256;

    // _owner: address of the owner.
    address private _owner;

    // _addressProject: address of a project.
    address payable private _addressProject;

    // _addressInvest: address of an investor.
    address private _addressInvestor;

    // _projectName: string of the name of the project.
    string private _nameProject;

    // _description: string of the description of the project.
    string private _description;

    // _location: string of the location of the project.
    string private _location;

    // _id is a counter of the number of projects.
    // _id is also a project ID.
    uint256 private _id;

    // _cost is the amount the project needs.
    uint256 private _cost;

    // IdentityProject is a struct with informations about the project.
    // Declaration of the struct type.
    struct IdentityProject {
        uint256 _id;
        string _nameProject;
        string _description;
        uint256 _cost;
        string _location;
    }

    // Declaration of the variable struct type.
    IdentityProject identityProjectVar = IdentityProject (
        {
            _id : _id,
            _nameProject : _nameProject,
            _description : _description,
            _cost : _cost,
            _location : _location
        }
    );

    // projectAddr: Mapping from an 'id' to the 'address' affiliated with.
    // _idProject => _addressProject
    mapping(uint256 => address) private _projectAddr;

    // projectId: Mapping from a registered project 'address' to an 'id'.
    // _addressProject => _idProject
    mapping(address => uint256) private _projectId;

    // idtProject: Mapping from an 'id' to the 'struct' of a project.
    // _id => struct IdentityProject
    mapping(uint256 => IdentityProject) private identityProject;

    // projectName: Mapping from an 'id' to the 'name' of the project.
    mapping(uint256 => string) private _projectName; 

    // projectDesc: Mapping from an 'id' to the 'description' of a project.
    mapping(uint256 => string) private _projectDesc;

    // projectCost: Mapping from an 'id' to the 'cost' of the project.
    mapping(uint256 => uint256) private _projectCost;

    // projectLoc: Mapping from an 'id' to the 'location' of a project.
    mapping(uint256 => string) private _projectLoc;

    // _balance : Mapping from account addresses to current balance.
    mapping (address => uint256) private _balance;

    constructor() {
        _owner = address(0x185D07b967ACD3b2600387656153b5725ddD01D7);
        _id = 0;
        _projectName[_id] = _nameProject;
        _projectDesc[_id] = _description;
        _projectCost[_id] = _cost;
        _projectLoc[_id] = _location;
        _projectAddr[_id] = _addressProject;
        _projectId[_addressProject] = _id; 
    }

    function register(
        address payable addressProject_,
        string memory nameProject_,
        string memory description_,
        uint256 cost_,
        string memory location_
    ) public {
        _id = _id.add(1);
        _addressProject = addressProject_;
        _nameProject = nameProject_;
        _description = description_;
        _cost = cost_;
        _location = location_;
        _projectAddr[_id] = addressProject_;
        _projectId[addressProject_] = _id;
        _projectName[_id] = nameProject_;
        _projectDesc[_id] = description_;
        _projectCost[_id] = cost_;
        _projectLoc[_id] = location_;
        identityProject[_id] = IdentityProject (
         _id,
        nameProject_,
        description_,
        cost_,
        location_
        );
    }

    function getProjectId(address addr_) public view returns (uint256) {
        return _projectId[addr_]; 
    }

    function getProject(uint256 id_) public view returns (IdentityProject memory) {
        return identityProject[id_];
    }

    function getProjectName(uint256 id_) public view returns (string memory) {
        return _projectName[id_];
    }

    function getProjectDesc(uint256 id_) public view returns (string memory) {
        return _projectDesc[id_];
    }

    function getProjectCost(uint256 id_) public view returns (uint256) {
        return _projectCost[id_];
    }

    function getProjectLoc(uint256 id_) public view returns (string memory) {
        return _projectLoc[id_];
    }

    // event Transfer(address indexed _from, address indexed _to, uint256 _value);
}
