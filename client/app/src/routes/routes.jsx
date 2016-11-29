import React from 'react';
import { Route, IndexRoute } from 'react-router';

import RequireAuth from '../containers/auth/RequireAuth';

import App from '../components/App';
import Home from '../components/Home';
import SignIn from '../containers/auth/SignIn';
import SignUp from '../containers/auth/SignUp';
import YourRecipes from '../containers/YourRecipes';
import NewRecipe from '../containers/NewRecipe';
import Completed from '../containers/Completed';

export default (
  <Route path="/" component={App}>
    <IndexRoute component={Home}/>
    <Route path="sign-in" component={SignIn}/>
    <Route path="sign-up" component={SignUp}/>
    <Route path="your-recipes" component={RequireAuth(YourRecipes)}/>
    <Route path="completed" component={RequireAuth(Completed)}/>
    <Route path="new-recipe" component={RequireAuth(NewRecipe)}/>
  </Route>
);
