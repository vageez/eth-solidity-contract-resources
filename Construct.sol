pragma solidity 0.7.5;

contract Construct {
    
    string message;
    
    constructor(string memory _message){
     message = _message;
    }
    
    function hello() public view returns(string memory){
        return message;
    }
}
