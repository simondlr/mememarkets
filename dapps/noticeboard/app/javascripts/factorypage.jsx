import React from "react";
import {TXComponent} from "reflux-tx";
import TxForm from "./txform.jsx";

/*
Page to create/issue a token.
Upon success/mined, forward to token wallet page.
*/

var FactoryPage = React.createClass({
  getInitialState: function() {
    return {
      value: ''
    }
  },
  successOnCreation: function(args, receipt) {
    this.props.history.pushState(null, '/stats/meme/' + receipt.contractAddress);
  },
  render: function() {
    return (
      <div>
        <TXComponent filter={{txType: "meme_creation"}}>
          <TxForm txType = "meme_creation"
                  header = "Create Meme"
                  msg = "Create Meme (if it does not exist)."
                  buttonAction = "Create Meme"
                  buttonProcessing = "Creating Meme"
                  successful = {this.successOnCreation}
                  inputs = {[{placeholder: "Meme Name", key: "name", ref: "name"}]}
            />
        </TXComponent> <br />
      </div>
    );
  }
});

module.exports = FactoryPage;
