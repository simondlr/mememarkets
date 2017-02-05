pragma solidity ^0.4.6;

import "./MemeToken.sol";
import "./MemeRegistry.sol";

//Factory/Registry to create Tokens & keep track of meme namespace & approval.
//If token for meme does not exist it will be created.
contract MemeFactory {
    MemeRegistry registry;

    function MemeFactory() {
      registry = new MemeRegistry();
    }

    //one token per meme
    function createMemeToken(string _meme) returns (address) {
        MemeToken mt = new MemeToken(registry, _meme); //might be inefficiant is this could be rolled back
        registry.registerMeme(_meme, address(mt));
        return address(mt);
    }
}
