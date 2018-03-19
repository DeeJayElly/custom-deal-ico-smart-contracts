pragma solidity ^0.4.11;

import './StandardToken.sol';
import '../Ownable.sol';

/**
 * @title MintableToken
 * @dev Simple ERC20 Token example, with mintable token creation
 * @dev Issue: * https://github.com/OpenZeppelin/zeppelin-solidity/issues/120
 * Based on code by TokenMarketNet: https://github.com/TokenMarketNet/ico/blob/master/contracts/MintableToken.sol
 */
contract MintableToken is StandardToken, Ownable {

    /**
     * Mint Event
     * @dev Event being at the start of minting
     * @param to The address which is minting
     * @param amount Amount being payed for minting
     */
    event Mint(address indexed to, uint256 amount);

    /**
     * MintFinished Event
     * @dev Event being fired after the minting is finished
     */
    event MintFinished();

    // mintingFinished set to true/false if the minting is finished or not
    bool public mintingFinished = false;

    // canMint modifier
    modifier canMint() {
        require(!mintingFinished);
        _;
    }

    /**
     * @title mint
     * @dev Function to mint tokens
     * @param _to The address that will receive the minted tokens.
     * @param _amount The amount of tokens to mint.
     * @return A boolean that indicates if the operation was successful.
     */
    function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool) {
        //totalSupply = totalSupply.add(_amount);
        balances[_to] = balances[_to].add(_amount);
        Mint(_to, _amount);
        Transfer(msg.sender, _to, _amount);
        return true;
    }

    /**
     * @title finishMinting
     * @dev Function to stop minting new tokens
     * @return True if the operation was successful
     */
    function finishMinting() onlyOwner public returns (bool) {
        mintingFinished = true;
        MintFinished();
        return true;
    }

    /**
     * @title burnTokens
     * @dev Function to burn all tokens
     * @param _unsoldTokens All unsold tokens
     * @return True if the tokens are burned
     */
    function burnTokens(uint256 _unsoldTokens) onlyOwner public returns (bool) {
        totalSupply = SafeMath.sub(totalSupply, _unsoldTokens);
    }
}
