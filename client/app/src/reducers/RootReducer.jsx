import { combineReducers } from 'redux';
import { i18nReducer } from 'react-redux-i18n';
import { reducer as formReducer } from 'redux-form';
import authReducer from './AuthReducer';
import recipesReducer from './RecipesReducer';

const RootReducer = combineReducers({
  i18n: i18nReducer,
  form: formReducer,
  auth: authReducer,
  recipes: recipesReducer
});

export default RootReducer;
