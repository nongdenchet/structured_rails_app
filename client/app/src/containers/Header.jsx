import React, { Component } from 'react';
import { Link } from 'react-router';
import { connect } from 'react-redux';
import { signOutUser } from '../actions/AuthAction';

class Header extends Component {
  render() {
    return (
      <div className="header">
        <nav className="navbar navbar-default" role="navigation">
          <div className="navbar-header">
            <button type="button" id="toggleInput" className="navbar-toggle">
              <span className="sr-only">Toggle navigation</span>
            </button>
            <Link className="navbar-brand" to="/">Coffee Recipes</Link>
          </div>
          <div className="navbar-right links">
            {this.renderLinks()}
          </div>
        </nav>
      </div>
    )
  }

  renderLinks() {
    return this.props.authenticated ? this.loggedInLinks() : this.loggedOutLinks();
  }

  loggedOutLinks() {
    return (
      <ul className="nav navbar-nav">
        <li><Link to="sign-in">Sign In</Link></li>
        <li><Link to="sign-up">Sign Up</Link></li>
      </ul>
    )
  }

  loggedInLinks() {
    return (
      <ul className="nav navbar-nav">
        <li><Link to="your-recipes">Your Recipes</Link></li>
        <li><Link to="completed">Completed</Link></li>
        <li><Link to="new-recipe">New Recipe</Link></li>
        <li><a href="#" onClick={this.props.signOutUser}>Sign Out</a></li>
      </ul>
    )
  }
}

function mapStateToProps(state) {
  return { authenticated: state.auth.authenticated };
}

export default connect(mapStateToProps, { signOutUser })(Header);
