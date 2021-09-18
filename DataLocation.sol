pragma solidity 0.7.5;

/**
 *
 * Data Location
 * 
 * 3 locations
 * 
 * 1. storage
 * persistent, stored permanently
 * 
 * 2. memory
 * temporary data storage. Stored for as long as the function runs
 * 
 * Value Data Types - ALWAYS STORED IN MEMORY Dont need to put memory
 * int
 * uint
 * bool
 * bytes
 * address
 * fix sized array 
 * 
 * Complex data types - Need to use memory
 * string
 * 
 * 3. calldata
 * similar to memory, but read only
 * 

 **/
 

 // type dataLocation varName
contract DataLocation {
 
 // state variables
 uint data = 123; // stored in storage
 
 function getString(string memory text) public pure returns(string memory) {
    return text;     
 }   
     
}
