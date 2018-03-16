pragma solidity ^0.4.13;

/**
 * @title CustomDealICO
 * @author Aleksandar Djordjevic
 * @dev Crowdsale is a base contract for managing a token crowdsale.
 * Crowdsales have a start and end timestamps, where investors can make
 * token purchases and the crowdsale will assign them CDL tokens based
 * on a CDL token per ETH rate. Funds collected are forwarded to a wallet
 * as they arrive.
 */

import '../contracts/crowdsale/Crowdsale.sol';
import '../contracts/crowdsale/CappedCrowdsale.sol';
import '../contracts/crowdsale/RefundableCrowdsale.sol';
import '../contracts/CustomDealToken.sol';

contract CustomDealICO is Crowdsale, CappedCrowdsale, RefundableCrowdsale {
    uint256 _startTime = now;
    uint256 _endTime = now + 30 minutes;
    uint256 _rate = 1300;
    uint256 _goal = 2000 * 1 ether;
    uint256 _cap = 17000 * 1 ether;
    address _wallet = 0x00000000000000000000000000000000;

    /** Constructor CustomDealICO */
    function CustomDealICO()
    CappedCrowdsale(_cap)
    FinalizableCrowdsale()
    RefundableCrowdsale(_goal)
    Crowdsale(_startTime, _endTime, _rate, _wallet) {
    }

    /** CustomToken Contract is generating from here */
    function createTokenContract() internal returns (MintableToken) {
        return new CustomDealToken();
    }
}