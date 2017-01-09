# Meme Markets

Meme Markets is a decentralized protocol built on Ethereum that allows the decentralized monetization of *all* memes (not just the "dank" variety).

One can tokenise interest in memes such as #ethereum, #simondlr, #vitalikbuterin, #harambe, #trump, #globalwarming, #football, #capetown, #USA, #twitter, #tcpip, #apple, #freemyvunk, etc without the requirement of a centralised intermediary.

By following a coded protocol in a smart contract that aims to express natural interest in a meme, it allows the tokenisation of said meme. Users dispense money (ETH) for action coupons in a meme according to a cost set by this coded/unchangeable algorithm, upon which they can then dispense the action coupons for services in the network of that meme. Action coupons for a specific meme becomes more costly as interest in that meme grows.

By having no centralised intermediary, not requiring current legal systems to provide services (such as incorporation of an organisation) & a more visible & common focal (schelling point), it reduces the barrier to entry to coordinate economically across the internet. The hope is that will provide new forms of agency to many people: from the birth of new kinds of organisations, new communities, personal markets and even better coordination around solving some of the world’s biggest problems such as global warming.

# Protocol Design

The alpha protocol (v0.1) currently works as follows:

-> A user can buy an action coupon in a meme with ETH (#simondlr, #ethereum, #apple, #footbal, etc).  
-> The cost of the coupon is dependent on how many action coupons are currently in supply for that meme. This algorithm is set in stone for each meme. It accrues linearly until a point where exponential costs take over. It's designed such that is unlikely (too costly) that any meme will have an outstanding supply of more than 10m coupons.  
-> Action coupons are dispensed for actions in the meme (anyone can build any app on top of this protocol to make the coupons usable/worth something).  

-> The beneficiary of the ETH used to buy the coupons are chosen by the buyer. A portion of funds are burnt to facilitate the fostering of the meme. For example, it will incentivize people to pay Vitalik Buterin in the #vitalikbuterin meme.  
-> Funds are locked for 1 month to avoid potential sybil attacks. This is a magic number and potential protocol improvements can be made.  

The whitepaper of the protocol design can be found here: https://docs.google.com/document/d/1CKK2jBYToHfkDM1XH4uVCSjXqOB6LxH8KdZbp8JHkqI/edit?usp=sharing

# Technicals

This is built using Truffle (beta of 3.x).

Solidity API:

There are 3 contracts:

#### MemeFactoryAndRegistry.sol

This keeps track of the namespace of memes and the creation of a token contract for a meme (if it hasn't been created yet).

```function approveContractForAllMemes(address _contract)```  
```function revokeContractForAllMemes(address _contract)```  
```function createMemeToken(string _meme)```  

#### MemeToken.sol

It uses [ERC20](https://github.com/ethereum/EIPs/issues/20) token standard as the base layer for each meme (transfer, approve, etc). It adds several functions around minting and dispensation of action coupons in each meme. The important API functions are:

```function mint(uint256 _amountToMint, address _beneficiary) payable```  
```function dispense(address _for, uint256 _amount)```  
```function mintAndDispense(uint256 _amountToMint, address _beneficiary, address _for, uint256 _amount) payable```   
```function claimFunds() returns (bool success)```

To build a dapp, you must let the users of your dapp approve your contract so that it can dispense coupons for any meme (in the meme markets). Otherwise, it works like a normal ERC20 token. You can approve a dapp for a specific meme, rather than *all* memes.

# The Noticeboard Dapp

The first dapp built on Meme Markets is a Noticeboard dapp. You dispense action coupons to upvote something on the noticeboard of that meme. Most upvoted remains the highest. Nothing fancier for now.

# Development

I'm still full-time involved @ ConsenSys, primarily developing Ujo & working on security/auditing of smart contracts. This is a side project, so any help will be appreciated.

The contract code is being finalized (mainly some last bits of optimization wrt state management of each meme), and the front-end has not started. I will like fork my [Token Factory](https://github.com/ConsenSys/token-factory) code and make simple forms.

# Disclaimer

It's very important to note that this is alpha software, and it can change/evolve as time goes on. Have fun. Check out #mememarkets (when it is live) for paying action coupons towards development of Meme Markets itself.
