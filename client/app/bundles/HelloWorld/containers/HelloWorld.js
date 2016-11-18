import React, {Component} from 'react';
import HelloWorldWidget from '../components/HelloWorldWidget';
import Header from '../components/Header';

export default class HelloWorld extends Component {

  constructor(props, context) {
    super(props, context);
    this.state = {name: this.props.name};
  }

  render() {
    return (
      <div className="hello-world-container">
        <Header/>
        <HelloWorldWidget name={this.state.name}/>
      </div>
    );
  }
}
