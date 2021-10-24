pragma solidity 0.7.5;
pragma abicoder v2;

// Storage using array
// Higher transaction cost to execute
contract Storage1 {
    
  struct Entity{
    uint data;
    address _address;
 }
 
 Entity[] public entities;
 
 function addEntity(uint data) public {
     Entity memory newEntity = Entity(data, msg.sender);
     entities.push(newEntity);
 }
 
 function updateEntity(uint data) public {
     if(entities.length == 0) revert();
     for(uint i = 0; i < entities.length; i++){
         if(entities[i]._address == msg.sender) {
            entities[i].data = data;   
         }
     }
 }
 
 function getEntityData() public view returns(uint) {
        uint entityData;
        for(uint i = 0; i < entities.length; i++){
         if(entities[i]._address == msg.sender) {
            entityData = entities[i].data;
         }
        }
        
        return entityData;
 }

}    


// Storage using mapping
// Less transaction cost to execute
contract Storage2 {
    
  
 mapping(address => uint) entities;
 
 function addEntity(uint data) public {
     if(entities[msg.sender] != 0) revert();
     entities[msg.sender] = data;
 }
 
 function updateEntity(uint data) public {
     if(entities[msg.sender] == 0) revert();
     entities[msg.sender] = data;
 }
 
 function getEntityData() public view returns(uint) {
    return entities[msg.sender];
 }

}    
