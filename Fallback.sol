pragma solidity 0.7.5;
pragma abicoder v2;

contract attack {
    
    // Calls with no data and no value
    recieve() external payable {
        // 
    }
    
    // Calls with no other function matches.
    // attack.add() - doesnt exist, will call fallback()
    fallback() external payable {
        // 
    }
}    
