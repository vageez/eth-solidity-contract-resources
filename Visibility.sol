pragma solidity 0.7.5;

/**
 * Visibility
 * 
 * Public: Anyone can execute the function, or access our variable.
 * When defining a PUBLIC Variable, a Getter function AUTOMATICALLY created to fetch the variable. 
 * 
 * Private: Who can execute or access the fcuntion; Can only be executed from within the contract itself
 * 
 * Internal: Same as private, also accessible from contracts deriving from it, that inherit it. 
 * 
 * External: Only accessibile from outside contracts, used in automated interactions with contracts
 * 
 **/
 
 
contract Visibility {
    
    mapping(address => uint) balance;
    
    function addBalance(uint _toAdd) public returns (uint) {
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    }
    
    function getBalance() public view returns (uint) {
        
        return balance[msg.sender];
    }
    
    function transfer(address recipient, uint amount) public {
        // check balance of msg.sender
        
        _transfer(msg.sender, recipient, amount);

        // event logs and further checks
    }
     
    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;         
    }
     
}
