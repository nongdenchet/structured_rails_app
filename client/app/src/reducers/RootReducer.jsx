import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import authReducer from './AuthReducer';

const RootReducer = combineReducers({
  form: formReducer,
  auth: authReducer
});

export default RootReducer;
