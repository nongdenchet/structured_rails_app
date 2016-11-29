import axios from 'axios';
import { browserHistory } from 'react-router';
import { AUTH_USER, DE_AUTH_USER } from '../actions/Types';
import { authError, authFromHeader } from '../utils/AuthUtils'

export function signInUser({ email, password }) {
  return function (dispatch) {
    axios.post('/users/sign_in', { email, password })
      .then(response => {
        handleSuccessAuthen(dispatch, response);
      })
      .catch(error => {
        var data = error.response.data;
        dispatch(authError(data.errors));
      })
  }
}

export function signUpUser({ email, password }) {
  return function (dispatch) {
    axios.post('/users', { email, password })
      .then(response => {
        handleSuccessAuthen(dispatch, response);
      })
      .catch(error => {
        var data = error.response.data;
        dispatch(authError(data.errors.full_messages));
      })
  }
}

export function signOutUser() {
  return function (dispatch) {
    dispatch({ type: DE_AUTH_USER });
    localStorage.removeItem('auth');
    browserHistory.push('');
  }
}

function handleSuccessAuthen(dispatch, response) {
  dispatch({ type: AUTH_USER });
  localStorage.setItem('auth', authFromHeader(response.headers));
  browserHistory.push('');
  dispatch(authError(null));
}
