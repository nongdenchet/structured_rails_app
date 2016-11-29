import React from 'react';
import ReactOnRails from 'react-on-rails';
import reduxThunk from 'redux-thunk';
import { Provider } from 'react-redux';
import { Router, browserHistory } from 'react-router';
import { createStore, applyMiddleware } from 'redux';
import reducers from './reducers/RootReducer';
import routes from './routes/routes';

const storeWithMiddleware = applyMiddleware(reduxThunk)(createStore);
const store = storeWithMiddleware(reducers);

const Index = (_props, _railsContext) => {
  return (
    <Provider store={store}>
      <Router history={browserHistory}>
        {routes}
      </Router>
    </Provider>
  );
};

ReactOnRails.register({ Index });

// Startup Config
import { configApi } from './configs/ApiConfig';
import { AUTH_USER } from './actions/Types';

configApi();
if (localStorage.getItem('auth')) {
  store.dispatch({ type: AUTH_USER });
}
