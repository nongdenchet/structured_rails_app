import React, { Component } from 'react';
import { Field, reduxForm } from 'redux-form';
import { connect } from 'react-redux';
import { signInUser } from '../../actions/AuthAction';
import { browserHistory } from 'react-router';

class SignIn extends Component {
  componentWillMount() {
    if (this.props.authenticated) {
      browserHistory.goBack('');
    }
  }

  render() {
    if (this.props.authenticated) {
      return <div></div>
    }
    const { handleSubmit, pristine, submitting } = this.props
    return (
      <div className="sign-in">
        <form
          className="col-md-5 col-md-offset-3"
          onSubmit={handleSubmit(this.submit.bind(this))}>
          {this.renderErrors()}
          <fieldset className="form-group">
            <label>Email:</label>
            <Field
              name="email"
              type="email"
              component="input"
              className="form-control"/>
          </fieldset>
          <fieldset className="form-group">
            <label>Password:</label>
            <Field
              name="password"
              type="password"
              component="input"
              className="form-control"/>
          </fieldset>
          <button type="submit"
                  disabled={pristine || submitting}
                  className="btn btn-primary">
            Sign In
          </button>
        </form>
      </div>
    )
  }

  submit({ email, password }) {
    this.props.signInUser({ email, password });
  }

  renderErrors() {
    if (this.props.errorMessages) {
      const errors = this.props.errorMessages.map(error => {
        return (
          <li key={error}>{error}</li>
        )
      })
      return (
        <ul className="alert alert-danger list-unstyled">{errors}</ul>
      )
    }
  }
}

function mapStateToProps(state) {
  return {
    errorMessages: state.auth.errors,
    authenticated: state.auth.authenticated
  }
}

export default connect(mapStateToProps, { signInUser })(
  reduxForm({ form: 'signInForm' })(SignIn)
)
