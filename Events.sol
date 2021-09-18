pragma solidity 0.7.5;

/**
 * Events
 * 
 * event EventName
 * 
 * event balanceAdded(uint amount, address depositedTo)
 * 
 * 1. indexed
 * 
 * Can index an event parameter.
 * Indexed by ethereum nodes. 
 * Can use those params to index and seaerch for events that happened in the past. 
 * 
 * Maximum of 3 indexed parameeters per event
 * 
 * Frontends in dapps can react to these EVENTS in our contracts.
 **/
 
 
contract ErrorHandling {
    
    mapping(address => uint) balance;
    address owner;
    
    event balanceAdded(uint amount, address depositedTo);
    event transferCompleted(uint amount, address to, address from);
    
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
        /**
         *  EVENT
         **/
        emit balanceAdded(_toAdd, msg.sender);
        /**
         *  EVENT
         **/
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

