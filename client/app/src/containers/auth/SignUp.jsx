import React, { Component } from 'react'
import { Field, reduxForm } from 'redux-form'
import { connect } from 'react-redux'
import { browserHistory } from 'react-router';
import validator from '../../validators/SignUpValidator'
import { signUpUser } from '../../actions/AuthAction'

class SignUp extends Component {
  componentWillMount() {
    if (this.props.authenticated) {
      browserHistory.goBack();
    }
  }

  renderField({ input, label, type, meta: { touched, error } }) {
    return (
      <div>
        <input {...input} placeholder={label} type={type} className="form-control"/>
        <font color="red">{touched && (error && <span>{error}</span>)}</font>
      </div>
    )
  }

  render() {
    if (this.props.authenticated) {
      return <div></div>
    }
    const { handleSubmit, pristine, submitting } = this.props
    return (
      <div className="sign-up">
        <form
          className="col-md-5 col-md-offset-3"
          onSubmit={handleSubmit(this.submit.bind(this))}>
          {this.renderErrors()}
          <fieldset className="form-group">
            <label>Email:</label>
            <Field
              name="email"
              type="email"
              component={this.renderField} />
          </fieldset>
          <fieldset className="form-group">
            <label>Password:</label>
            <Field
              name="password"
              type="password"
              component={this.renderField} />
          </fieldset>
          <fieldset className="form-group">
            <label>Confirmation:</label>
            <Field
              name="confirm"
              type="password"
              component={this.renderField} />
          </fieldset>
          <button
            type="submit"
            disabled={pristine || submitting}
            className="btn btn-primary">
            Sign Up
          </button>
        </form>
      </div>
    )
  }

  submit({ email, password }) {
    this.props.signUpUser({ email, password });
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

export default connect(mapStateToProps, { signUpUser })(
  reduxForm({
    form: 'signUpForm',
    validate: validator
  })(SignUp)
)
