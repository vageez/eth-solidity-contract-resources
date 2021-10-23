
contract {
    
    uint[] storageArray // [1,2,3,4,7]
    
    // assign by copy
    // assign by reference / pointer
    
    // storage -> memory COPY
    // memory -> storage COPY
    
    // memory -> memory REFERENCE
    // storage -> local REFERENCE
    
    function f(uint[] memory memoryArray) { // [1,2,3,4]
        // ASSIGN BY COPY
        storageArray = memoryArray;
        
        uint[] storage pointerArray = storageArray; 
        // pointerArray will point to starageArray
        // updating one will update the other
        
        memoryArray = pointerArray; // local => memory COPY
        
        // memoryArray is now [1,2,3,4,7]
    }
}
