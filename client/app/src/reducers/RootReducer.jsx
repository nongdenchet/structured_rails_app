import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import authReducer from './AuthReducer';
import recipesReducer from './RecipesReducer';

const RootReducer = combineReducers({
  form: formReducer,
  auth: authReducer,
  recipes: recipesReducer
});

export default RootReducer;
