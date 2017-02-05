import React from 'react';
import { Link } from 'react-router';

/*
Home/front page.
Warns if offline and recommends to install Metamask to use it.
*/

var FrontPage = React.createClass({
  getInitialState: function() {
    return {
      offline_msg: ''
    };
  },
  componentDidMount: function() {
  },
  render: function() {
    if(window.offline) {
      // reroute to offline page. Easier
    }
    return (
      <div>
        <h2 style={{textAlign: 'center'}}> M E M E M A R K E T S (Alpha WIP) </h2>
        <br />
        <p >
        Decentralized monetization of *all* information (memes) and its network effects. <br />
      <br />
      </p>
        <h2>Top Memes</h2>
        #simondlr - 24 Tokens In Circulation <br />
        #ujo - 20 Tokens In Circulation <br />


      </div>
    );
  }
});

module.exports = FrontPage;
