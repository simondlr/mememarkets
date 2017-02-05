import React from "react";
import {TXComponent} from "reflux-tx";
import TxForm from "./txform.jsx";


var AboutPage = React.createClass({
  getInitialState: function() {
    return {
    };
  },
  componentDidMount: function() {
  },
  render: function() {
    return (
      <div>
        <h2>M E M E M A R K E T S</h2>
        Meme Markets is a decentralized protocol built on Ethereum that allows the decentralized monetization of all information and their network effects (memes).<br />
        <br />
        One can tokenise interest in memes such as #ethereum, #simondlr, #vitalikbuterin, #harambe, #trump, #globalwarming, #football, #capetown, #USA, #twitter, #tcpip, #apple, #freemyvunk, etc without the requirement of a centralised intermediary.<br />
        <br />
        By following a coded protocol in a smart contract that aims to express natural interest in a meme, it allows the tokenisation of said meme. Users dispense money (ETH) for action coupons in a meme according to a cost set by this coded/unchangeable algorithm, upon which they can then dispense the action coupons for services in the network of that meme. Action coupons for a specific meme becomes more costly as interest in that meme grows.<br />
        <br />
        By having no centralised intermediary, not requiring current legal systems to provide services (such as incorporation of an organisation) & a more visible & common focal (schelling point), it reduces the barrier to entry to coordinate economically across the internet. The hope is that will provide new forms of agency to many people: from the birth of new kinds of organisations, new communities, personal markets and even better coordination around solving some of the world’s biggest problems such as global warming.
      </div>
    );
  }
});

module.exports = AboutPage;
