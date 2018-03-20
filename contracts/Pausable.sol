pragma solidity ^0.4.8;

import './Ownable.sol';

/*
 * @title Pausable
 * @dev Abstract contract that allows children to implement an
 * emergency stop mechanism.
 */
contract Pausable is Ownable {

    // Stopped true/false state
    bool public stopped;

    // stopInEmergency modifier
    modifier stopInEmergency {
        if (stopped) {
            revert();
        }
        _;
    }

    // onlyInEmergency modifier
    modifier onlyInEmergency {
        if (!stopped) {
            revert();
        }
        _;
    }

    /**
     * @dev Called by the owner on emergency, triggers stopped state
     */
    function emergencyStop() external onlyOwner {
        stopped = true;
    }

    /**
     * @dev Called by the owner on end of emergency, returns to normal state
     */
    function release() external onlyOwner onlyInEmergency {
        stopped = false;
    }
}