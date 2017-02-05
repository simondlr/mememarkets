import React from "react";
import {TXComponent} from "reflux-tx";
import TxForm from "./txform.jsx";


var MemeStatsPage = React.createClass({
  getInitialState: function() {
    return {
    };
  },
  componentDidMount: function() {
    console.log(this.props.params.memeStr);
  },
  render: function() {
    var meme = this.props.params.memeStr;
    return (
      <div>
        <h2>#{meme}</h2>
        Upvote any piece of text with this meme's tokens. <br />
        [] - [Submit] <br />
        + - 4 : Hello!
      </div>
    );
  }
});

module.exports = MemeStatsPage;
