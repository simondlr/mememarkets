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
        <br />
        Current Supply: 24 <br />
        Current Cost Per Token: 0.0001 eth <br />
        Total Ever Minted: 100 <br />

        <h3>Top Beneficiaries</h3>
        <h3>Recent Beneficiaries</h3>
      </div>
    );
  }
});

module.exports = MemeStatsPage;
