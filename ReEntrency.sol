pragma solidity 0.7.5;
pragma abicoder v2;

// Protect against Re-Entry attack
// CHECKS, EFFECTS (changing state),  INTERACTIONS - patters
// Execute in this order
contract ReEntrency {
    
    mapping(address => uint) balances;
    function withdraw() public {
        // CHECKS
        require(balances[msg.sender] > 0);
        // EFFECTS (changing state)
        balances[msg.sender] = 0;
        // INTERACTIONS
        msg.sender.send(balances[msg.sender]);
    }

}    
