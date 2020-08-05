// SPDX-License-Identifier: MIT
pragma solidity ^0.6.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../compound/ICToken.sol";
import "./TestERC20.sol";

/**
 * @title TestCDai
 * @author Alexander Schlindwein
 *
 * @dev cDai token for testing
 */
contract TestCDai is ERC20, ICToken {

    TestERC20 _dai;

    /**
     * @dev Constructs a new TestCDai
     * @param dai The address of the test dai
     */
    constructor (address dai) public ERC20("cDai", "cDai") {
        _dai = TestERC20(dai);
    }

    /**
     * @dev Updates the interest - not implemented for testing
     */
    function accrueInterest() external returns (uint) {
        return 0;
    }

    /**
     * @dev Mints a given amount of tokens to an address in exchange for dai.
     *
     * @param mintAmount The amount of Dai to spend for minting
     */
    function mint(uint mintAmount) external returns (uint) {
        require(_dai.allowance(msg.sender, address(this)) >= mintAmount, "cDai mint: not enough allowance");
        require(_dai.transferFrom(msg.sender, address(this), mintAmount), "cDai mint: dai transfer failed");


    }

    /**
     * @dev Returns the exchange rate for cDai -> Dai
     * @dev For testing, we add 10**18 for every block
     */
    function exchangeRateStored() external view returns (uint) {
        return uint(10**18).add(block.number.mul(10**18))
    }
}