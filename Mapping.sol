pragma solidity 0.7.5;

/**
 * Mappings 
 * 
 * Key Value storage/data type, dictionary, hashmap
 * 
 * KEY -> Value
 * 
 * Balance Mapping, create token in smart contract, balance Mappings
 * Address -> Balance
 * 
 * defining mapping
 * mapping(keyType => valueType) name
 * mapping(address => uint) balance
 * 
 * set balance: balance[address] = 10
 * get balance: balance[address]
 * 
 * 
 * 
 **/
 
contract Mappings {
    
    mapping(address => uint) balance;
    
    function addBalance(uint _toAdd) public returns (uint) {
        // balance[msg.sender] = balance[msg.sender] + _toAdd
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    }
    
    function getBalance() public view returns (uint) {
        
        return balance[msg.sender];
    }
    
}
