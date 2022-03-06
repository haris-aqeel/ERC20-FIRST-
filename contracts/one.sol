// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Identity {

    string name;
    uint age;

    constructor() {
        name="Haris Aqeel";
        age=18;
    }

    function getName() public view returns(string memory){
        return name;
    }

    function getAge() public view returns(uint){
        return age;
    }

    function setName(string memory _name) public {
        name = _name;
    }

    function incrementAge() public {
        age = age + 1;
    }

}