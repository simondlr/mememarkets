pragma solidity ^0.4.6;

/*
This is for testing if a transaction would throw.

Contract calls rethrow when it encounters errors.
Raw calls do not.
You wrap your contract you want to test in a ThrowProxy.
You prime it by calling the fallback function.
Then executing it.

False will be returned if it threw or OOGed.
True will be returned if it did not throw or OOGed.

This could eventually be turned into a generic TestProxy.
*/
contract ThrowProxy {

    address public target;
    bytes data;

    function ThrowProxy(address _target) {
        target = _target;
    }

    //prime the data using the fallback function.
    function() {
        data = msg.data;
    }

    function execute() returns (bool) {
        return target.call(data);
    }
}
