import React from 'react';
import { Route, IndexRoute } from 'react-router';

import App from '../components/App';
import Home from '../components/Home';
import YourRecipes from '../containers/YourRecipes';
import NewRecipe from '../containers/NewRecipe';
import Completed from '../containers/Completed';

export default (
  <Route path="/" component={App}>
    <IndexRoute component={Home}/>
    <Route path="your-recipes" component={YourRecipes}/>
    <Route path="completed" component={Completed}/>
    <Route path="new-recipe" component={NewRecipe}/>
  </Route>
);
