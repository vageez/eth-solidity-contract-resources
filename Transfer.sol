pragma solidity 0.7.5;

/**
 * TRASFER
 * 
 * withdraw function
 * 
 * 
   msg.sender.transfer(amount);
 * is exactly the same as 
   address payable toSend = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
   toSend.transfer(amount);
 * 
 **/
 
 /**
 Contract structure
 address -> balance
 address -> balance
 address -> balance
 address -> balance
 address -> balance
 ...
 SUM TOTAL balance of all addresses is held in the contract
 
 When we deposit 
 Use function headers function deposit() public payable
 Store the deposit amount to the address that has added it in memory. address => Balance
 

 When we withdraw 
 
 validate the address => Balance is sufficient
 Update the address => Balance stored in memory

 Transfer the amount from the SUM of the contract. msg.sender.transfer(amount);
 
 **/
 
contract Transfer {
    
    mapping(address => uint) balance;
    address owner;
    
    event depositCompleted(uint amount, address depositedTo);
    event transferCompleted(uint amount, address to, address from);
    
    constructor(){
        // Only executed on deployment on Contract
        // Owner is the person who deployed the contract
        owner = msg.sender;
    }
    
    function withdraw(uint amount) public returns (uint){
        // Check the balance of the user, before withdrawing
        require(balance[msg.sender] >= amount);
        // Manage Internal contract balance
        balance[msg.sender] -= amount;
        // Transfer from this contract address to the senders address
        msg.sender.transfer(amount);
        // Return balance of user from memory
        return balance[msg.sender];
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
    
    function transfer(address recipient, uint amount) public {
        // check balance of msg.sender
        require(balance[msg.sender] >= amount, "Balance not sufficient");
        require(msg.sender != recipient, "Cannot transfer money to yourself");
        
        uint previousBSenderBalance = balance[msg.sender];
        
        _transfer(msg.sender, recipient, amount);

        // event logs and further checks
        assert(balance[msg.sender] == previousBSenderBalance - amount);

    }
     
    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;   
        emit transferCompleted(amount, to, from);
    }
     
}

