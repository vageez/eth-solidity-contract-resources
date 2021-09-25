pragma solidity 0.7.5;
pragma abicoder v2;


contract Wallet{ 
    
    address[] public owners;
    uint public limit;
    
    struct Transfer {
        uint txId;
        uint amount;
        address payable receiver;
        uint approvals;
        bool hasBeenSent;
    }
    
    Transfer[] transferRequests;
    mapping(address => mapping(uint => bool)) approvals;
    
    modifier ownlyOwners() {
        bool isOwner;
        for(uint i = 0; i < owners.length; i++){
            if(owners[i] == msg.sender){
                isOwner = true;
            }
        }
        require(isOwner == true);
        _;
    }
    
    modifier selfApprovalRestriction (uint _txId) {
        require(transferRequests[_txId].receiver != msg.sender);
        _;
    }
    
    constructor(address[] memory _owners, uint _limit){
        limit = _limit;
        
        for(uint i = 0; i < _owners.length; i++){
            owners.push(_owners[i]);
        }
    }
    
    function getBalance() public view ownlyOwners returns (uint) {
        return address(this).balance;
    }
    
    function deposit() public payable {
        
    }
    
    function createTransfer(uint _amount, address payable _receiver) public ownlyOwners {
        Transfer memory transferRequest = Transfer({
            txId: transferRequests.length,
            amount: _amount,
            receiver: _receiver,
            hasBeenSent: false,
            approvals: 0
        });
        
        transferRequests.push(transferRequest);
    }
    
    function approve(uint _txId) public ownlyOwners selfApprovalRestriction(_txId) {
        // Cannot vote twice
        require(approvals[msg.sender][_txId] == false);
        // Make sure transfer has not already been sent
        require(transferRequests[_txId].hasBeenSent == false);
        approvals[msg.sender][_txId] = true;
        transferRequests[_txId].approvals++;
        if(transferRequests[_txId].approvals >= limit) {
            transferRequests[_txId].hasBeenSent = true;
            // PAY
            transferRequests[_txId].receiver.transfer(transferRequests[_txId].amount);
        }
    }
    
    function getTransferRequests() public view returns (Transfer[] memory) {
        return transferRequests;
    }
    
}
