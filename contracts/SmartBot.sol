/* SPDX-License-Identifier: MIT */
pragma solidity ^0.8.7;

import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";

contract SmartBot {
    IUniswapV2Router02 uniswap;
    IUniswapV2Router02 sushiswap;

    constructor(){
        uniswap=IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        sushiswap=IUniswapV2Router02(0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F);
    }

    function swapTokens(address[] calldata path, uint256 amountIn, uint256 amountOutMin) external {
        uint256[] memory uniswapAmounts = uniswap.getAmountsOut(amountIn, path);
        uint256[] memory sushiSwapAmounts = sushiswap.getAmountsOut(amountIn, path);

        if (uniswapAmounts[uniswapAmounts.length - 1] >= sushiSwapAmounts[sushiSwapAmounts.length - 1]) {
            uniswap.swapExactTokensForTokens(amountIn, amountOutMin, path, msg.sender, block.timestamp);
        } else {
            sushiswap.swapExactTokensForTokens(amountIn, amountOutMin, path, msg.sender, block.timestamp);
        }
    }
}
