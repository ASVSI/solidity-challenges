// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

interface AggregatorV3Interface {
    function latestRoundData()
        external
        view
        returns (
            uint80,
            int256,
            uint256,
            uint256,
            uint80
        );

    function decimals() external view returns (uint8);
}

contract PriceConsumer {
    AggregatorV3Interface public priceFeed;

    constructor(address _priceFeed) {
        require(_priceFeed != address(0), "Invalid feed");
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    function getETHPrice() external view returns (int256) {
        (, int256 price,,,) = priceFeed.latestRoundData();
        return price;
    }
}
