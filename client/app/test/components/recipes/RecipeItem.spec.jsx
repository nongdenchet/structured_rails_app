import { expect } from 'chai'
import { shallow } from 'enzyme'
import { spy } from 'sinon'
import React from 'react'
import RecipeItem from '../../../src/components/recipes/RecipeItem';

describe('RecipeItem', () => {
  describe('rendering', () => {
    it('should render title', () => {
      const recipe = { title: 'title' }
      const wrapper = shallow(<RecipeItem recipe={recipe} />)
      expect(wrapper.find('h3')).to.have.text('title')
    })

    it('should render description', () => {
      const recipe = { description: 'description' }
      const wrapper = shallow(<RecipeItem recipe={recipe} />)
      expect(wrapper.find('p')).to.have.text('description')
    })
  })
})
