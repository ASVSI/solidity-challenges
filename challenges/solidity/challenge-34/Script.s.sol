// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Script.sol";
import "../src/PriceConsumer.sol";
import "../test/mocks/MockV3Aggregator.sol";

contract DeployPriceConsumer is Script {
    address public priceFeed;

    function run() external {
        vm.startBroadcast();

        if (block.chainid == 1) {
            // SEPOLIA ETH / USD
            priceFeed = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        }
        else if (block.chainid == 11155111) {
            // MAINNET ETH / USD
            priceFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
        }
        else if (block.chainid == 31337) {
            // Local Anvil network
            priceFeed = address(new MockV3Aggregator(8, 2000e8));
        }
        else {
            revert("Unsupported network");
        }

        new PriceConsumer(priceFeed);

        vm.stopBroadcast();
    }
}