pragma solidity 0.7.5;
pragma abicoder v2;

/**
 * Here
 * 
 **/
 
 
contract MultiSug {
    event depositAdded (uint amount, address depositor);
    event transferRequestSubmitted (uint amount, address requestAddr);
    event transferRequestApproval (uint txId, address requestAddr, bool abool);
    uint public num_signers;
    address[] public addresses;
    mapping(address => mapping(uint => bool)) approvals;    
    
    struct TransferRequest {
        address requestAddr;
        uint amount;
        uint approvals;
        uint txId;
    }
    
    TransferRequest[] transferRequests;


    constructor(address[] memory _address, uint _num_signers) {
        num_signers = _num_signers;
        
        for(uint i = 0; i < _address.length; i++){
            addresses.push(_address[i]);
        }
    }
    
    function deposit() public payable {
        emit depositAdded(msg.value, msg.sender);
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function setTransferRequest(uint _amount) public {
     bool addressIsSigner = false;
     for(uint i = 0; i < addresses.length; i++){
         if(addresses[i] == msg.sender){
             addressIsSigner = true;
         }
     }
     if(addressIsSigner) {
        TransferRequest memory transferRequest = TransferRequest({
             requestAddr: msg.sender, 
             amount: _amount, 
             approvals: 0, 
             txId: transferRequests.length
         });
         
         transferRequests.push(transferRequest);
         emit transferRequestSubmitted(_amount, msg.sender);
     } else {
        revert();
     }
     
    }
    
    function approveTransferRequest(uint _txId) public {
        require(transferRequests[_txId].requestAddr != msg.sender);
         transferRequests[_txId].approvals = transferRequests[_txId].approvals + 1;
         approvals[msg.sender][_txId] = true;
         emit transferRequestApproval(_txId, msg.sender, approvals[msg.sender][_txId]);
    }
    
    function isTrasferable(uint _txId) private {
        
    }
    
    
    function getTransferRequest(uint _txId) public view returns(address, uint, uint, uint) {
        return (
            transferRequests[_txId].requestAddr, 
            transferRequests[_txId].amount, 
            transferRequests[_txId].approvals, 
            transferRequests[_txId].txId
        );
    }
    
    
     
}

