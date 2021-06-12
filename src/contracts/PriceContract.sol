pragma solidity ^0.6.7;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract PriceContract {

    AggregatorV3Interface internal priceFeed;
    // State Variables
    uint public id=0;
    // It keeps the summing the prices that we retrieve so that average can be found out easily
    int public sum=0;
    
    /* 
        mapping(uint=>Price) prices;
        
        I could've used this as well but since, we're fetching a non-logical data here
        i.e., which contains only some values, it's better to use arrays here. (Often arrays are costlier).
    */
    
    
    // This structure will only store ID, timeStamp and price
    struct Price{
        uint ID;
        uint timeStamp;
        int price; 
    }
    // Array of struct to store persistent values
    Price[] public prices;

    constructor() public {
        priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
    }

// CREATE
    function storePrice() public payable {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        prices.push(Price(id, timeStamp, price));
        id+=1;
        sum+= price;
    }

// RETRIEVE- Gives price and the timestamp
    function getThePrice(uint _index) public view returns (int, uint) {
        require(_index>0 && _index<prices.length, "Index must be between the range of the array");
        Price storage priceObj= prices[_index];
        return (int(priceObj.price), priceObj.timeStamp);
    }
    
// UTIL (Average of all the prices)
    function averagePrice() public view returns(int){
        /* 
        *** NOTE: It's not advisable to iterate over arrays that are unbounded ***
        *** Hence, I used this method of saving the sum of all the prices as soon as I get them, for gas efficiency ***
        
        THIS IS THE APPROACH WITH LOOPING OVER THE LIST TO GET ALL PRICES AND FINDING AVERAGE

        int sum_=0;
        for(uint i=0;i<prices.length;i++){
            
            sum_+= prices[i].price;
        }

        return int(sum_/int(id));
        */        
        
        return sum/int(prices.length);   
    }

//   DELETE AN ENTRY *** Here pop() would make more sense as deletion of a price related data is vague ***
    function deleteEntry(uint _index) public{
        require(_index>0 && _index<prices.length, "Index must be between the range of the array");
        delete prices[_index];  // It'll just put a string "0" in place of that entry
    }
}