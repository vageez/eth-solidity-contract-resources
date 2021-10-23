
contract {
    
    uint[] storageArray // [1,2,3,4,7]
    
    // assign by copy
    // assign by reference / pointer
    
    // storage -> memory COPY
    // memory -> storage COPY
    
    // memory -> memory REFERENCE
    // storage -> local REFERENCE
    
    function f(uint[] memory memoryArray) { // [1,2,3,4]
        storageArray = memoryArray; // memory -> memory COPY
        
        uint[] storage pointerArray = storageArray; // memory -> local REFERENCE
        
        pointerArray.push(7); // push into storageArray
        
        memoryArray = pointerArray; // local => memory COPY
        
        // memoryArray is now [1,2,3,4,7]
    }
}
