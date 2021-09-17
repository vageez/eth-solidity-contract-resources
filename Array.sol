pragma solidity 0.7.5;

// Arrays

contract Arrays {
    
    int number;
    int[] numbers;
    
    function addNumber(int _integer) public {
        numbers.push(_integer);
    }
    
    function getNumber(uint _index) public view returns(int){
        if(numbers.length > _index) {
            return numbers[_index];    
        } else {
            return 0;
        }
    }
    
    function getNumbers() public view returns(int[] memory){
        return numbers;
    }
    
}
