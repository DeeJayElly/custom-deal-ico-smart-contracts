pragma solidity ^0.4.11;

import '../SafeMath.sol';
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
     * @dev CappedCrowdsale Constructor
     * @param _cap Capitalization value
     */
    function CappedCrowdsale(uint256 _cap) public {
        require(_cap > 0);
        cap = _cap;
    }

    /**
     * @dev Overriding Crowdsale#validPurchase to add extra cap logic
     * @return True if investors can buy at the moment
     */
    function validPurchase() internal constant returns (bool) {
        bool withinCap = weiRaised.add(msg.value) <= cap;
        return super.validPurchase() && withinCap;
    }

    /**
     * @dev Overriding Crowdsale#hasEnded to add cap logic
     * @return True if crowdsale event has ended
     */
    function hasEnded() public constant returns (bool) {
        bool capReached = weiRaised >= cap;
        return super.hasEnded() || capReached;
    }
}
