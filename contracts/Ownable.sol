pragma solidity ^0.4.11;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of 'user permissions'
 */
contract Ownable {

    // Address of the owner
    address internal owner;

    /**
     * OwnershipTransferred Event
     * @dev Fired when the ownership of the contract is transfered from one previous owner to new owner
     * @param previousOwner Previous owner address
     * @param newOwner New owner address
     */
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev The Ownable constructor sets the original `owner` of the contract to the sender
     * account
     */
    function Ownable() public {
        owner = msg.sender;
    }

    // onlyOwner Modifier - Throws if called by any account other than the owner
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) onlyOwner public {
        require(newOwner != address(0));
        OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}
