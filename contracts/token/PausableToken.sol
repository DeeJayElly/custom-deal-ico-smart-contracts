pragma solidity ^0.4.11;

import './StandardToken.sol';
import '../Pausable.sol';

/**
 * @title Pausable token
 * @dev StandardToken modified with pausable transfers
 **/
contract PausableToken is StandardToken, Pausable {

    /**
     * @title transfer
     * @dev Function transfer funds
     * @param _to Receiver address
     * @param _value Amount being sent
     * @return True if the operation was successful
     */
    function transfer(address _to, uint256 _value) public whenNotPaused returns (bool) {
        return super.transfer(_to, _value);
    }

    /**
     * @title transferFrom
     * @dev Function transfer funds from specific address
     * @param _from Sender address
     * @param _to Receiver address
     * @param _value Amount being sent
     * @return True if the operation was successful
     */
    function transferFrom(address _from, address _to, uint256 _value) public whenNotPaused returns (bool) {
        return super.transferFrom(_from, _to, _value);
    }

    /**
     * @title approve
     * @dev Function to approve transfer
     * @param _spender Spender's address
     * @param _value Amount being approved for sending
     * @return True if the operation was successful
     */
    function approve(address _spender, uint256 _value) public whenNotPaused returns (bool) {
        return super.approve(_spender, _value);
    }

    /**
     * @title increaseApproval
     * @dev Increase approval function
     * @param _spender Spender's address
     * @param _addedValue Amount being received
     * @return True if the operation was successful
     */
    function increaseApproval(address _spender, uint _addedValue) public whenNotPaused returns (bool success) {
        return super.increaseApproval(_spender, _addedValue);
    }

    /**
     * @title decreaseApproval
     * @dev Decrease approval function
     * @param _spender Spender's address
     * @param _subtractedValue Amount being sent
     * @return True if the operation was successful
     */
    function decreaseApproval(address _spender, uint _subtractedValue) public whenNotPaused returns (bool success) {
        return super.decreaseApproval(_spender, _subtractedValue);
    }
}
