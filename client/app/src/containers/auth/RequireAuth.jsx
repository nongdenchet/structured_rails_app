import React, { Component } from 'react';
import { connect } from 'react-redux';
import { browserHistory } from 'react-router';

export default function(ComposedComponent) {
  class RequireAuth extends Component {
    componentWillMount() {
      this.checkAuthentication(this.props.authenticated);
    }

    componentWillUpdate(newProps) {
      this.checkAuthentication(newProps.authenticated);
    }

    checkAuthentication(authenticated) {
      if (!authenticated) {
        browserHistory.push("sign-in");
      }
    }

    render() {
      return <ComposedComponent { ...this.props } />
    }
  }

  function mapStateToProps(state) {
    return { authenticated: state.auth.authenticated };
  }

  return connect(mapStateToProps)(RequireAuth);
}
