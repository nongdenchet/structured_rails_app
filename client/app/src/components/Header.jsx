import React, { Component } from 'react';
import { Link } from 'react-router';

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
            <ul className="nav navbar-nav">
              <li><Link to="your-recipes">Your Recipes</Link></li>
              <li><Link to="completed">Completed</Link></li>
              <li><Link to="new-recipe">New Recipe</Link></li>
            </ul>
          </div>
        </nav>
      </div>
    )
  }
}

export default Header;
