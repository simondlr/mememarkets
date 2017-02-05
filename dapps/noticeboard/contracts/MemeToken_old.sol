pragma solidity ^0.4.6;

import "./ERC20Token.sol";
import "./MemeRegistry.sol";

/*
This is an older MemeToken that still has commented code on the attempts to code
state burning.
*/

//Token Per Meme
contract MemeToken is ERC20Token {

    MemeRegistry public memeRegistry;
    uint256 baseCost = 100000000000000; //100000000000000 wei 0.0001 ether
    uint256 public costPerToken = 0;
    string public meme;

    //todo: Add human standard vanity vars per token

    uint256 public totalEverMinted;
    uint256 public totalEverDispensed;

    mapping(address => Owed[]) public owed;

    mapping(address => uint256) public scores;

    uint public delay = 10 seconds; //testing
    //mainnet will be 1 month.

    struct Owed {
        uint256 created;
        uint256 withdrawTime;
        uint256 amount;
    }

    function MemeToken(address _registry, string _meme) {
        memeRegistry = MemeRegistry(_registry); //get the factory address
        updateCostOfToken(0); //first pass
        meme = _meme;
    }

    // via: http://ethereum.stackexchange.com/questions/10425/is-there-any-efficient-way-to-compute-the-exponentiation-of-a-fraction-and-an-in/10432#10432
    // Computes `k * (1+1/q) ^ N`, with precision `p`. The higher
    // the precision, the higher the gas cost. It should be
    // something around the log of `n`. When `p == n`, the
    // precision is absolute (sans possible integer overflows).
    // Much smaller values are sufficient to get a great approximation.
    function fracExp(uint k, uint q, uint n, uint p) internal returns (uint) {
      uint s = 0;
      uint N = 1;
      uint B = 1;
      for (uint i = 0; i < p; ++i){
        s += k * N / B / (q**i);
        N  = N * (n-i);
        B  = B * (i+1);
      }
      return s;
    }

    function updateCostOfToken(uint256 supply) internal {
        //from protocol design:
        //costOfCoupon = (BaseCost + BaseCost*(1.000001618^AvailableSupply)+BaseCost*AvailableSupply/1000)
        //totalSupply == AvailableSupply
        costPerToken = baseCost+fracExp(baseCost, 618046, supply, 2)+baseCost*supply/1000;
        LogCostOfTokenUpdate(costPerToken);
    }

    //mint
    function mint(uint256 _amountToMint, address _beneficiary) payable returns (bool) {
        //balance of msg.sender increases if paid right amount according to protocol

        if(_amountToMint > 0 && msg.value > 0) {

          //uint256 totalCost = costPerToken * _amountToMint;
          uint256 totalMinted = 0;
          uint256 totalCost = 0;
          //for loop to determine cost at each point.
          for(uint i = 0; i < _amountToMint; i+=1) {
              if(totalCost + costPerToken <= msg.value) {
                  totalCost += costPerToken;
                  totalMinted += 1;
                  updateCostOfToken((totalSupply+i));
              } else {
                  break;
              }
          }

          if(totalCost < msg.value) { //some funds left, not enough for one token. Send back funds
              if(!msg.sender.send(msg.value - totalCost)) { throw; }
          }

          //add committed funds to time lock
          owed[_beneficiary].push(Owed({
              created: now,
              withdrawTime: now + delay,
              amount: totalCost
          }));

          totalEverMinted += totalMinted;
          totalSupply += totalMinted;

          scores[_beneficiary] += 1;

          LogMint(_beneficiary, totalMinted, totalCost);
          LogBeneficiaryUpdate(_beneficiary, scores[_beneficiary]);

          return true;
        } else {
          throw;
        }
    }

    function claimFunds() returns (bool success) {
        //this setup with arrays are sybil attackable atm.
        //it's assumed that the cost of the coupons will mitigate this.
        bool fundsReturned = false;
        for(uint i = 0; i < owed[msg.sender].length; i+=1) {
            if(owed[msg.sender][i].withdrawTime >= now) {
                if(!msg.sender.send(owed[msg.sender][i].amount)) { throw; }
                fundsReturned = true;
            }
        }

        //todo: array elements should be deleted/removed to avoid gas attacks.

        return fundsReturned;
    }

    /*function calculatePercentageBurn(address _beneficiary) returns (uint256) {
        uint256 percent = 100 - currentBurnProportions[_beneficiary]*100/totalSupply;
        return percent;
    }*/

    //dispense
    /*
    - keeping it simple for now. ERC20 approve (per user per token per address)
    is not included in this check.
    */
    function dispense(address _for, uint256 _amount) returns (bool) {
        //approved[user][dapp/contract] aka approved for all memetokens
        if(_amount > 0) {
          if(memeRegistry.approved(_for, msg.sender) == true) {
              if(balances[_for] >= _amount) {
                  balances[_for] -= _amount;
                  totalSupply -= _amount;
                  totalEverDispensed += _amount;

                  //updateBurnStateAfterDispense();
                  LogDispense(_for, _amount);
                  return true;
              } else { throw; }
          }
        }
    }

    /*function updateBurnStateAfterMint(address _beneficiary) internal {
        uint256 index = indexes[_beneficiary];
        //zero == leader && if not found. Thus need to make sure.
        if(index == 0 && scores[0] != _beneficiary) {
            //aka not the current leader, but a new entrant.
            scores.push(0); //a new player has entered the game
            addressLeaderboard.push(_beneficiary);
            indexes[_beneficiary] = scores.length; //right at the end
            index = indexes[_beneficiary]; //update index
        }

        scores[index] += 1;

        //is not leader or the new entrant
        if(index != 0 || index != scores.length) {
            //if higher in position.
            if(scores[index] > scores[index-1]) {
              //swap scores
              uint256 scoreSwap = scores[index];
              scores[index] = scores[index-1];
              scores[index-1] = scoreSwap;

              //swap leaderboard
              address addressSwap = addressLeaderboard[index];
              addressLeaderboard[index] = addressLeaderboard[index-1];
              addressLeaderboard[index-1] = addressSwap;

              //change indexes
              indexes[addressLeaderboard[index]] = index;
              indexes[addressLeaderboard[index-1]] = index-1;
            }
        }
    }

    function updateBurnStateAfterDispense() internal {
        if(currentBurnProportions[firstBeneficiary] > 0) {
            currentBurnProportions[firstBeneficiary] -= 1;
            if(currentBurnProportions[secondBeneficiary] > currentBurnProportions[firstBeneficiary]) {
                address swapAddress = firstBeneficiary;
                firstBeneficiary = secondBeneficiary;
                secondBeneficiary = swapAddress;
            }
        }
    }*/

    //mintAndDispense
    function mintAndDispense(uint256 _amountToMint, address _to, address _for, uint256 _amount) payable {
        mint(_amountToMint, _to);
        dispense(_for, _amount);
    }

    event LogMint(address indexed beneficiary, uint256 amountMinted, uint256 totalCost);
    event LogBeneficiaryUpdate(address indexed beneficiary, uint256 currentScore);
    event LogDispense(address indexed _for, uint256 amount);
    event LogCostOfTokenUpdate(uint256 newCost);
}
