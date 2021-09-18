pragma solidity 0.7.5;

/**
 * Payments
 * 
 * payable 
 * 
 * allows function to recieve money when they call it. 
 * 
 **/
 
 
contract Payment {
    
    mapping(address => uint) balance;
    address owner;
    
    event depositCompleted(uint amount, address depositedTo);
    
    constructor(){
        // Only executed on deployment on Contract
        // Owner is the person who deployed the contract
        owner = msg.sender;
    }
    
    function deposit() public payable returns (uint) {
        // The value deposited goes to the SUM total value of this Contract.
        // The code below is to simply log and distinguish which address owns which part of the overall balance. 
        balance[msg.sender] += msg.value;
        emit depositCompleted(msg.value, msg.sender);
        return balance[msg.sender];
    }
    
    function getBalance() public view returns (uint) {
        
        return balance[msg.sender];
    }
     
}

