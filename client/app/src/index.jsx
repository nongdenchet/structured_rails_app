import React from 'react';
import ReactOnRails from 'react-on-rails';
import reduxThunk from 'redux-thunk';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import reducers from './reducers/RootReducer';
import router from './route';

const storeWithMiddleware = applyMiddleware(reduxThunk)(createStore);
const store = storeWithMiddleware(reducers);

const Index = (_props, _railsContext) => {
  return (
    <Provider store={store}>
      {router}
    </Provider>
  );
};

ReactOnRails.register({ Index });
