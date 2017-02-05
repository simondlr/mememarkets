import React from "react";

/*
Simple forwarding tool to simply forward to a token page when putting in an address so the user don't have to fiddle with the URL.
*/

var SearchPage = React.createClass({
  getInitialState: function() {
    return {
      value: ''
    }
  },
  handleChange: function(event) {
    this.setState({value: event.target.value});
  },
  render: function() {
    return (
      <div>
        Enter the meme in order to see its stats: <br />
        <br />
        <span><label>#</label> <input className="form-control" type="text" value={this.state.value} placeholder="simondlr" onChange={this.handleChange}/></span>
        <br />
        <button className="btn btn-default" onClick={this.executeFunction}>Go to Meme</button>
      </div>
    );
  },
  executeFunction: function() {
    console.log(this.state.value);
    this.props.history.pushState(null,'/stats/meme/'+this.state.value);
  }
});

module.exports = SearchPage;
