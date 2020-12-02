// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;
pragma experimental ABIEncoderV2;
import "@openzeppelin/contracts/math/SafeMath.sol";

contract Linkable {
    using SafeMath for uint256;

    // _ownerLinkable: address of the owner.
    address private _ownerLinkable;

    // _addressProject: address of a project.
    address private _addressProject;

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

    // IdentityProject contains informations about the project.
    struct IdentityProject {
        uint256 _id;
        string _projectName;
        string _creatorName;
        string _description;
        uint256 _projectAmount;
        string location;
    }

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

    constructor() {
        _ownerLinkable = address(0x185D07b967ACD3b2600387656153b5725ddD01D7);
        _id = 0;
        projectAddr[_id] = _addressProject;
        projectId[_addressProject] = _id;
        creatorAddr[_addressProject] = _addressCreator;
    }

    function register(
        address addressProject_,
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
    }

    function getProject(uint256 id_) public view returns (IdentityProject memory) {
        return identityProject[id_];
    }

    function getAmount() public view {}

    function getLocation() public view {}

    function donate() public payable {}
}
