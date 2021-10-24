pragma solidity 0.7.5;
pragma abicoder v2;

// Send and transfer
// 2300 Gas stipend
// msg.sender.call.value(amount)("")


contract SendAndTransfer {
    
    mapping(address => uint) balances;
    function withdraw() public {
        // CHECKS
        require(balances[msg.sender] > 0);
        
        uint toTransfer = balances[msg.sender];
        
        // EFFECTS (changing state)
        balances[msg.sender] = 0;
        
        // INTERACTIONS
        // Proper way to make a transfer
        (bool success, ) = msg.sender.call{value: toTransfer}("");
        
        if(!success) {
            // Failt transfer, reset state EFFECTS (changing state)
            balances[msg.sender] = toTransfer;    
        }
        
    }

}    
