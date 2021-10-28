pragma solidity 0.7.5;
pragma abicoder v2;


import "SafeMath.sol";

// Use SafeMath Lib to prevent over and under flow. 

contract underflow {
    
    // uint8 can handle up to the number 255
    // OVERFLOW
    // uint8 number = 255
    // number = number + 1
    // number now equals 0, reached the max, and started over again.
    // number = number + 2
    // number now equals 1 (number == 1)
    
    // UNDERFLOW
    // uint8 number = 0
    // number = number - 1
    // number == 255
    
    using SafeMath for uint256;

    uint256 n = 0;
    function add() public returns(uint8) {
        n = n.add(1);
        return n;
    } 
    
    function subtract() public returns(uint8) {
        n = n.sub(1);
        return n;
    } 
}   

