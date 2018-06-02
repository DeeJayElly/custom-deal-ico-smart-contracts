pragma solidity ^0.4.18;

/**
 * @title Migrations
 * @dev Migrations contract base
 */
contract Migrations {

    // Owners address
    address public owner;

    // Last completed migration value
    uint public last_completed_migration;

    // restricted modifier
    modifier restricted() {
        if (msg.sender == owner) _;
    }

    /**
     * @dev Migrations Constructor
     */
    function Migrations() public {
        owner = msg.sender;
    }

    /**
     * @dev Set complete migration after successful migration
     * @param completed True/false based on the completed state
     */
    function setCompleted(uint completed) public restricted {
        last_completed_migration = completed;
    }

    /**
     * @dev Upgrade migration function
     * @param new_address New address where the contract is migrated
     */
    function upgrade(address new_address) public restricted {
        Migrations upgraded = Migrations(new_address);
        upgraded.setCompleted(last_completed_migration);
    }
}
