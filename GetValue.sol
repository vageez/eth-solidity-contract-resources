/**
* Get Value of contract
*
**/


function contractSum() public view returns (uint) {
    return address(this).balance;
}
