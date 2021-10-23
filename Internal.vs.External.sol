pragma solidity 0.7.5;
pragma abicoder v2;


contract GasTest {
    
    // Cheaper gas
    // External NOT PUBLIC, cannot be used in public functions
    // Calldata args are not written to memory
    // Calldata args are read from the function call
    // Since numbers are not saved anywhere, we CANNOT modify this array
    function testExternal(uint[10] calldata numbers) external returns (uint) {
        return numbers[0];
    }
    
    function testPublic(uint[10] memory numbers) public returns (uint){
        return numbers[0];
    }
}
