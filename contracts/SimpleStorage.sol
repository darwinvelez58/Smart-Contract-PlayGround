//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract SimpleStorage {
    uint256 favorityNumber;
    bool favorityBool;

    struct People {
        uint256 favorityNumber;
        string name;
    }

    People[] public people;
    mapping(string => uint256) public nameToFavorityNumber;

    function store(uint256 _favorityNumber) public returns(uint256){
        favorityNumber = _favorityNumber;
        return favorityNumber;
    }

    function retrieve() public view returns(uint256){
        return favorityNumber;
    }

    function addPerson(string memory _name, uint256 _favorityNumber) public {
        people.push(People(_favorityNumber, _name));
        nameToFavorityNumber[_name] = _favorityNumber;
    }
}