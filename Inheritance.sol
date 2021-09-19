pragma solidity 0.7.5;

/**
* Inheritance
* https://medium.com/coinmonks/solidity-and-object-oriented-programming-oop-191f8deb8316
**/

/**
* Can also import Parent contract like so.
* When deploying a contract which inherits from another contract, a SINGLE contract is deployed to the block chain. 
* import "./Ownable.sol"
**/

contract Ownable {
    address owner;
        
    constructor(){
        // Only executed on deployment on Contract
        // Owner is the person who deployed the contract
        owner = msg.sender;
    }
    
    // Modifier is added to function header, and is executed before the function
    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract creator has permissions");
        _; // => run the function
    }
    
} 

contract Bank is Ownable {
    
    mapping(address => uint) balance;
    
    event depositCompleted(uint amount, address depositedTo);
    event transferCompleted(uint amount, address to, address from);
    
    
    function withdraw(uint amount) public onlyOwner returns (uint){
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

