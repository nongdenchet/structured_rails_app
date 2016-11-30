import { expect } from 'chai'
import { mount } from 'enzyme'
import axios from 'axios'
import sinon from 'sinon'
import { default as MockAdapter } from 'axios-mock-adapter'
import reduxThunk from 'redux-thunk';
import React from 'react'
import { createStore, applyMiddleware } from 'redux'
import rootReducer from '../../src/reducers/RootReducer'
import Home from '../../src/containers/Home'
import { authFromLocal } from '../../src/utils/AuthUtils';

const store = applyMiddleware(reduxThunk)(createStore)(rootReducer);
const context = { store };
const mock = new MockAdapter(axios)

describe('Home', () => {
  beforeEach(() => {
    window.localStorage = {
      getItem(key) {
        return "{\"type\" : \"json\"}";
      }
    };
    mock.onGet('/recipes/feeds').reply(200, {
      recipes: [
        {
          id: 1,
          title: 'title 1',
          description: 'description 1',
        },
        {
          id: 2,
          title: 'title 2',
          description: 'description 2',
        }
      ]
    }, authFromLocal())
  })

  it('should render Hello World', (done) => {
    sinon.stub(window.localStorage, 'getItem', () => {
      return false;
    })
    const wrapper = mount(<Home />, { context })
    setTimeout(function() {
      expect(wrapper).to.contain.text('Hello')
      done();
    }, 10);
  })

  it('should render title', (done) => {
    const wrapper = mount(<Home />, { context })
    setTimeout(function() {
      expect(wrapper.find('h3').at(0)).to.contain.text('title 1')
      expect(wrapper.find('h3').at(1)).to.contain.text('title 2')
      done();
    }, 10);
  })

  it('should render description', (done) => {
    const wrapper = mount(<Home />, { context })
    setTimeout(function() {
      expect(wrapper.find('p').at(0)).to.contain.text('description 1')
      expect(wrapper.find('p').at(1)).to.contain.text('description 2')
      done();
    }, 10);
  })
})
