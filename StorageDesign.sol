pragma solidity 0.7.5;
pragma abicoder v2;


//
//  Create
//  Read
//  Update
//  Delete
//

contract StorageDesign {
    
    struct EntityStruct {
        uint entityData;
        // more data ...
        uint listPointer;
    }
    
    mapping(address => EntityStruct) public entityStructs;
    
    address[] public entityList;    

    function isEntity(address entityAddress) public view returns (bool isNeeded) {
        if(entityList.length == 0) return false;
        return (entityList[entityStructs[entityAddress].listPointer] == entityAddress);
        
    }
    
    function newEntity(address entityAddress, uint entityData) public returns (bool success){
        // If it already exists, we revert
        if(isEntity(entityAddress)) revert();
        // Add the address into the array
        entityList.push(entityAddress);
        // Set the entityData
        entityStructs[entityAddress].entityData = entityData;
        // Set the index in the struct
        entityStructs[entityAddress].listPointer = entityList.length - 1;
        return true;
    }
    
    function updateEntity(address entityAddress, uint entityData) public returns (bool success) {
        // If it does not exist, we revert
        if(!isEntity(entityAddress)) revert();
        entityStructs[entityAddress].entityData = entityData;
        return true;
    }
    
    
    // Example, remove add2
    // [add1, add2, add3, add4, add5]
    // Removing add 2, will result in below
    // move add5 to its spot, and pop last element
    // [add1, add5, add3, add4]
    
    function deleteEntity(address entityAddress) public returns (bool success) {
        // If it does not exist, we revert
        if(!isEntity(entityAddress)) revert();
        // Find the place in the Array
        uint rowToDelete = entityStructs[entityAddress].listPointer;
        
        address keyToMove = entityList[entityList.length-1]; // Save add5
        entityList[rowToDelete] = keyToMove; // Set add5 where add2 is
        entityStructs[keyToMove].listPointer = rowToDelete; // Set pointer to new row index from 5 to 2
        entityList.pop();
        
        return true;
    }

}    
