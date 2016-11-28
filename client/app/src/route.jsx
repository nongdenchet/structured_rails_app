import React from 'react';
import { Router, Route, IndexRoute, browserHistory } from 'react-router';

import App from './components/App';
import Home from './components/Home';

export default (
  <Router history={browserHistory}>
    <Route path="/" component={App}>
      <IndexRoute component={Home}/>
    </Route>
  </Router>
);
