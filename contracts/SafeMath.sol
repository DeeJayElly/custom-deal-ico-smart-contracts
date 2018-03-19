pragma solidity ^0.4.11;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

    /**
     * @title mul
     * @dec Multiple of 2 unit numbers
     * @param a First value
     * @param b Second value
     * @return Multiplied value
     */
    function mul(uint256 a, uint256 b) internal constant returns (uint256) {
        uint256 c = a * b;
        assert(a == 0 || c / a == b);
        return c;
    }

    /**
     * @title div
     * @dec Divide of 2 unit numbers
     * @param a First value
     * @param b Second value
     * @return Divided value
     */
    function div(uint256 a, uint256 b) internal constant returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    /**
     * @title sub
     * @dec Subtraction of 2 unit numbers
     * @param a First value
     * @param b Second value
     * @return Subtracted value
     */
    function sub(uint256 a, uint256 b) internal constant returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    /**
     * @title add
     * @dec Add of 2 unit numbers
     * @param a First value
     * @param b Second value
     * @return Sum value
     */
    function add(uint256 a, uint256 b) internal constant returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}
