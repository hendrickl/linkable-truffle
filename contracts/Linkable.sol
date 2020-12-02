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

    // _ownerLinkable: address of the owner.
    address private _ownerLinkable;

    // _addressProject: address of a project.
    address payable private _addressProject;

    // _addressCreator: address of a project creator.
    address private _addressCreator;

    // _addressInvest: address of an investor.
    address private _addressInvestor;

    // _projectName: string of the name of the project.
    string private _projectName;

    // _creatorName: string of the name of the creator.
    string private _creatorName;

    // _description: string of the description of the project.
    string private _description;

    // _location: string of the location of the project.
    string private _location;

    // _id is a counter of the number of projects.
    // _id is also a project ID.
    uint256 private _id;

    // _projectAmount is the amount the project needs.
    uint256 private _projectAmount;

    // IdentityProject is a struct with informations about the project.
    // Declaration of the struct type.
    struct IdentityProject {
        uint256 _id;
        string _projectName;
        string _creatorName;
        string _description;
        uint256 _projectAmount;
        string _location;
    }

    // Declaration of the variable struct type.
    IdentityProject IdentityProjectVar = IdentityProject (
        {
            _id : _id,
            _projectName : _projectName,
            _creatorName : _creatorName,
            _description : _description,
            _projectAmount : _projectAmount,
            _location : _location
        }
    );

    // idtProject: Mapping FROM an ID TO the struct of a project.
    // _id => struct IdentityProject
    mapping(uint256 => IdentityProject) public identityProject;

    // projectAddr: Mapping FROM an ID TO the address affiliated with.
    // _id => _addressProject
    mapping(uint256 => address) public projectAddr;

    // creatorAddr: Mapping FROM an project address TO its creator address.
    // _addressProject => _addressCreator
    mapping(address => address) public creatorAddr;

    // projectId: Mapping FROM a registered project address TO an ID.
    // _addressProject => _id
    mapping(address => uint256) public projectId;

    // _balance : Mapping from account addresses to current balance.
    mapping (address => uint256) private _balance;

    constructor() {
        _ownerLinkable = address(0x185D07b967ACD3b2600387656153b5725ddD01D7);
        _id = 0;
        projectAddr[_id] = _addressProject;
        projectId[_addressProject] = _id;
        creatorAddr[_addressProject] = _addressCreator;
    }

    function register(
        address payable addressProject_,
        address addressCreator_,
        string memory projectName_,
        string memory creatorName_,
        string memory description_,
        uint256 projectAmount_,
        string memory location_
    ) public {
        _id = _id.add(1);
        _addressProject = addressProject_;
        _addressCreator = addressCreator_;
        _projectName = projectName_;
        _creatorName = creatorName_;
        _description = description_;
        _projectAmount = projectAmount_;
        _location = location_;
        projectAddr[_id] = addressProject_;
        projectId[addressProject_] = _id;
        creatorAddr[addressProject_] = addressCreator_;
        identityProject[_id] = IdentityProject (
         _id,
        projectName_,
        creatorName_,
        description_,
        projectAmount_,
        location_
        );
    }

    function getProject(uint256 id_) public view returns (IdentityProject memory) {
        return identityProject[id_];
    }

    // donate() moves `projectAmount_` eth from the caller's account to `addressProject_`.
    // Returns a boolean value indicating whether the operation succeeded.
    function donate(address addressProject_, uint256 projectAmount_) public returns (bool) {
        require(_balance[msg.sender] >= projectAmount_, 'Linkable : Transfer amount exceeds balance');
        _balance[msg.sender] = _balance[msg.sender].sub(projectAmount_.mul(1**18 wei));
        _balance[addressProject_] = _balance[addressProject_].add(projectAmount_.mul(1**18 wei));
        emit Transfer(msg.sender, addressProject_, projectAmount_);
        return true;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}
