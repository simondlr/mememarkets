pragma solidity ^0.4.6;

//Keep track of meme namespace & approvals.
contract MemeRegistry {
    //memes <=> token addresses
    mapping(string => address) memeTokens;
    //user <=> dapp/contract approval (for all memes)
    mapping(address => mapping(address => bool)) public approved;

    address factory;

    function MemeRegistry() {
      factory = msg.sender;
    }

    function registerMeme(string _meme, address _token) returns (bool success) {
      if(msg.sender == factory && memeTokens[_meme] == 0x0) {
        memeTokens[_meme] = _token;
        return true;
      } else {
        throw;
      }
    }

    //give a specific dapp access to trade all memes (tokens) on your behalf
    function approveContractForAllMemes(address _contract) {
        //approve contract to alter balance of ALL one's tokens.
        approved[msg.sender][_contract] == true;
    }

    function revokeContractForAllMemes(address _contract) {
        approved[msg.sender][_contract] == false;
    }


}
