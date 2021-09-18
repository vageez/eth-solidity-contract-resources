pragma solidity 0.7.5;

/**
 *
 * Error Handling
 * 
 * require()
 * Check for valid conditions. 
 * CHeck conditions
 * Check inputs
 * 
 * Anf failiure automatically triggers Revert
 * Revert
 * 
 * require(input > 100)
 * require(msg.sender == owner, "Message to display if condition fails")
 * 
 * 
 * Assert
 * assert()
 * Only checks for internal erros
 * Checks for invariants.
 * You run after the Contract executes. 
 * EG: Checking your balance, after you send money
 * 
 * Invariants
 * A concept, a condition that is always true at a particular point in time.
 * WitdrawAll function, when done executing assert that the Invariant (balance is 0) is true. 
 * 
 * 
 **/
 
 
contract ErrorHandling {
    
    mapping(address => uint) balance;
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
    
    function addBalance(uint _toAdd) public onlyOwner returns (uint) {
        balance[msg.sender] += _toAdd;
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
    }
     
}






