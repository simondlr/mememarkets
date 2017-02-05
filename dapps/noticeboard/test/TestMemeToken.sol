pragma solidity ^0.4.6;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/ThrowProxy.sol";
import "../contracts/MemeToken.sol";
import "../contracts/MemeFactory.sol";

contract TestMemeToken {

  MemeFactory factory = new MemeFactory();
  MemeToken simondlr;
  ThrowProxy throwProxy;

  // set up
  function beforeAll() {
    address simondlrAddress = factory.createMemeToken("simondlr");
    simondlr = MemeToken(simondlrAddress);
    throwProxy = new ThrowProxy(simondlrAddress); //set proxy destination
  }

  //testTestingTools
  //make sure it's not the proxy that's causing errs
  /*function testMintingWithThrowProxy() {
    //wont throw.

  }*/

  //testMinting
  //test trying to mint zero
  function testMintZero() {

    //bool result = simondlr.mint.value(0)
    //wrap & then prime the proxy.
    MemeToken(address(throwProxy)).mint(0, 0x42);
    //execute proxy function.
    bool result = throwProxy.execute(); //zero will be sent and thus err

    Assert.isFalse(result, "Result should be false (tx throws) as minting zero should not be possible.");
  }

  //test trying to mint 1 with msg.value that is zero
  function testMintZero() {

    //bool result = simondlr.mint.value(0)
    //wrap & then prime the proxy.
    MemeToken(address(throwProxy)).mint(0, 0x42);
    //execute proxy function.
    bool result = throwProxy.execute(); //zero will be sent and thus err

    Assert.isFalse(result, "Result should be false (tx throws) as minting zero should not be possible.");
  }
  //test minting 1
  //test minting 5
  //test minting 10
  //test minting 100
  //test minting 1000000
  //test minting 5 with not enough money
  //mint exact amount (5) (not sending anything back)

  //testDispensing
  //test dispense

  //test mint, then dispense

  //test mint&dispense

  //testState ((currently not doing any state state related))
  //test beneficiary count increased after mint
  //test top beneificiary count decrease after dispense
  //test top beneficiary change when just minted for beneficiary is equal or greater
  //test second beneificiary remaining second after mint and not higher than top beneficiary
  //test state of top beneficiary when dispensed and second beneficiary is greater (switch)
}
