pragma solidity 0.7.5;

contract Number {
    
    int number;
    
    function getNumber() public view returns(int) {
        return number;
    }
    
    function setNumber(int _number) public{
        number = _number;
    }

}
