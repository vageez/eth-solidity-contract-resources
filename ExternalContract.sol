pragma solidity 0.7.5;

/**
 * External Contract example
 * 
 * To be interacted with via an Interface
 * 
 * 
 **/
 
contract Government {

    struct Transaction {
        address from;
        address to;
        uint amount;
        uint txId;
    }
    
    Transaction[] transactionLog;

    function addTransaction(address _to, address _from, uint _amount) external {
        // Transaction memory _transaction = Transaction(_to, _from, _amount, transactionLog.length);
        // transactionLog.push(Transaction(_to, _from, _amount, transactionLog.length));
        
        // Alternative; less code. 
        transactionLog.push(Transaction(_to, _from, _amount, transactionLog.length));
    }
    
    // Cannot return a struct
    function getTransaction(uint _txId) public view returns(address, address, uint) {
        return (transactionLog[_txId].from, transactionLog[_txId].to, transactionLog[_txId].amount);
    }
    
    
}
