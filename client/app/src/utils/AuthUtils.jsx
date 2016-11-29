import { AUTH_ERROR } from '../actions/Types';

export function authError(errors) {
  return {
    type: AUTH_ERROR,
    payload: errors
  }
}

export function authFromLocal() {
  return JSON.parse(localStorage.getItem('auth'));
}

export function isAuthenticated() {
  return localStorage.getItem('auth');
}

export function authFromHeader(headers) {
  return JSON.stringify({
    'access-token': headers['access-token'],
    'uid': headers['uid'],
    'client': headers['client']
  });
}
