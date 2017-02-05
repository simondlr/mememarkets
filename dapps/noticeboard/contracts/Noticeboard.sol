pragma solidity ^0.4.6;

import "./MemeToken.sol";

contract Noticeboard {

    mapping(string => uint256) notices;

    function upvote(address _memeTokenAddress, string _text, uint256 _weight) returns (bool) {

        if(MemeToken(_memeTokenAddress).dispense(msg.sender, _weight)) {
            notices[_text] += _weight;
            return true;
        } else { return false; }
    }

    //todo add state reading functions eg:
    //get recent upvotes
    //get top all time
}
