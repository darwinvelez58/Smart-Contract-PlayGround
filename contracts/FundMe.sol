// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe {
    using SafeMathChainlink for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;
    AggregatorV3Interface public priceFeed;

    /**
        @dev The constructor sets the owner of the contract to the address that deployed the contract
        and sets the price feed contract address to the one provided in the constructor
        @param _priceFeed: The address of the price feed contract e.g Sepolia:usd
     */
    constructor(address _priceFeed) public {
        priceFeed = AggregatorV3Interface(_priceFeed);
        owner = msg.sender;
    }

    /**
        @dev The fund function allows users to fund the contract with a minimum of 50 USD
        @notice The function requires that the user sends more than 50 USD worth of ETH
        @notice The function updates the amount funded by the user and adds the user to the funders array
     */
    function fund() public payable {
        uint256 minimumUSD = 50 * 10**18;
        require(
            getConversionRate(msg.value) >= minimumUSD,
            "You need to spend more ETH!"
        );
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    /**
        @dev The getVersion function returns the version of the price feed contract
        @return uint256: The version of the price feed contract
     */
    function getVersion() public view returns (uint256) {
        return priceFeed.version();
    }

    /**
        @dev The getPrice function returns the latest price of the price feed contract
        @return uint256: The latest price of the price feed contract
     */
    function getPrice() public view returns (uint256) {
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        return uint256(answer * 10000000000);
    }

    /**
        @dev The getConversionRate function returns the conversion rate of the amount of ETH sent to USD
        @param ethAmount: The amount of ETH sent by the user
        @return uint256: The conversion rate of the amount of ETH sent to USD
    */
    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }

    /**
        @dev The getEntranceFee function returns the minimum amount of ETH required to fund the contract
        @return uint256: The minimum amount of ETH required to fund the contract
     */
    function getEntranceFee() public view returns (uint256) {
        // minimumUSD
        uint256 minimumUSD = 50 * 10**18; // $50
        uint256 price = getPrice();
        uint256 precision = 1 * 10**18;
        return ((minimumUSD * precision) / price) + 1;
    }

    /**
        @dev The withdraw function allows the owner of the contract to withdraw all the funds in the contract
        @notice The function transfers the funds in the contract to the owner
        @notice The function resets the amount funded by each user and the funders array
        @notice The function can only be called by the owner of the contract
     */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /**
        @dev The withdraw function allows the owner of the contract to withdraw all the funds in the contract
        @notice The function transfers the funds in the contract to the owner
        @notice The function resets the amount funded by each user and the funders array
        @notice The function can only be called by the owner of the contract
     */
    function withdraw() public payable onlyOwner {
        msg.sender.transfer(address(this).balance);

        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }
}