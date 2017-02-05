import React from "react";
import {TXComponent} from "reflux-tx";
import TxForm from "./txform.jsx";


var NoticeboardFrontPage = React.createClass({
  getInitialState: function() {
    return {
    };
  },
  componentDidMount: function() {
  },
  render: function() {
    return (
      <div>
        The Noticeboard is a dapp that uses the meme markets platform.<br />
      <br />
        It allows one to dispense meme tokens to upvote text for that specific meme.<br />
      <br />
        Recent upvoted text in memes <br />
      <br />
        #simondlr <br />
        #ethereum
      </div>
    );
  }
});

module.exports = NoticeboardFrontPage;
