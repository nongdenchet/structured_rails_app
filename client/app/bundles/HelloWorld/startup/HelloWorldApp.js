import React from 'react';
import ReactOnRails from 'react-on-rails';

import HelloWorld from '../containers/HelloWorld';

const HelloWorldApp = (props) => (
  <HelloWorld {...props} />
);

ReactOnRails.register({ HelloWorldApp });
