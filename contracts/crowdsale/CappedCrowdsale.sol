pragma solidity ^0.4.11;

import '../math/SafeMath.sol';
import './Crowdsale.sol';

/**
 * @title CappedCrowdsale
 * @dev Extension of Crowdsale with a max amount of funds raised
 */
contract CappedCrowdsale is Crowdsale {

    // Using SafeMath library for math operations
    using SafeMath for uint256;

    // cap value
    uint256 public cap;

    /**
     * @title CappedCrowdsale
     * @dev CappedCrowdsale Constructor
     */
    function CappedCrowdsale(uint256 _cap) {
        require(_cap > 0);
        cap = _cap;
    }

    /**
     * @title validPurchase
     * @dev Overriding Crowdsale#validPurchase to add extra cap logic
     * @return true if investors can buy at the moment
     */
    function validPurchase() internal constant returns (bool) {
        bool withinCap = weiRaised.add(msg.value) <= cap;
        return super.validPurchase() && withinCap;
    }

    /**
     * @title validPurchase
     * @dev Overriding Crowdsale#hasEnded to add cap logic
     * @return true if crowdsale event has ended
     */
    function hasEnded() public constant returns (bool) {
        bool capReached = weiRaised >= cap;
        return super.hasEnded() || capReached;
    }
}
