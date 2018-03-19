pragma solidity ^0.4.13;

import './crowdsale/Crowdsale.sol';
import './crowdsale/CappedCrowdsale.sol';
import './crowdsale/RefundableCrowdsale.sol';
import './CustomDealToken.sol';

/**
 * @title CustomDealICO
 * @author Aleksandar Djordjevic
 * @dev Crowdsale is a base contract for managing a token crowdsale
 * Crowdsales have a start and end timestamps, where investors can make
 * token purchases and the crowdsale will assign them CDL tokens based
 * on a CDL token per ETH rate. Funds collected are forwarded to a wallet
 * as they arrive
 */
contract CustomDealICO is Crowdsale, CappedCrowdsale, RefundableCrowdsale {

    // Start time of the ICO
    uint256 _startTime = now;

    // End time of the ICO
    uint256 _endTime = now + 30 minutes;

    // Current token rate
    uint256 _rate = 1300;

    // Goal of the ICO amount - Soft cap
    uint256 _goal = 2000 * 1 ether;

    // Hard cap amount for the ICO
    uint256 _cap = 17000 * 1 ether;

    // Wallet address
    address _wallet = 0x00000000000000000000000000000000;

    /**
     * @title CustomDealICO
     * @dev CustomDealICO Constructor
     */
    function CustomDealICO()
    CappedCrowdsale(_cap)
    FinalizableCrowdsale()
    RefundableCrowdsale(_goal)
    Crowdsale(_startTime, _endTime, _rate, _wallet) {
    }

    /**
     * @title createTokenContract
     * @dev Creating main token contract
     * @return Token instance which is mintable
     */
    function createTokenContract() internal returns (MintableToken) {
        return new CustomDealToken();
    }
}