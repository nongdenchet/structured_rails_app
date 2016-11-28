import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';

const RootReducer = combineReducers({
  form: formReducer,
});

export default RootReducer;
