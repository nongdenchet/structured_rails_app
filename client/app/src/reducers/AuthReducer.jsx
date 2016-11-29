import { AUTH_USER, DE_AUTH_USER, AUTH_ERROR } from '../actions/Types';

export default function (state = {}, action) {
  switch (action.type) {
    case AUTH_USER:
      return { ...state, authenticated: true };
    case DE_AUTH_USER:
      return { ...state, authenticated: false };
    case AUTH_ERROR:
      return { ...state, errors: action.payload }
  }
  return state;
}
