pragma solidity 0.7.5;

/**
 *  External Contracts
 *  Need external contract specs to add the interface
 * 
 * 
 **/
 
interface GovernmentInterface {
    function addTransaction(address _to, address _from, uint _amount) external;
}
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

contract Destroyable is Ownable {
    
    function destroy() public onlyOwner { 
        address payable receiver = msg.sender;
        selfdestruct(receiver); 
    }
}

contract Bank is Ownable, Destroyable {

     // Importing an external contract
    GovernmentInterface governmentInstance = GovernmentInterface(0x8059B0AE35c113137694Ba15b2C3585aE77Bb8E9);
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
        
        // Calling external contract
        governmentInstance.addTransaction(msg.sender, recipient, amount);

        // event logs and further checks
        assert(balance[msg.sender] == previousBSenderBalance - amount);

    }
     
    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;   
        emit transferCompleted(amount, to, from);
    }
     
}

