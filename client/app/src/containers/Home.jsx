import React, { Component } from 'react';
import { connect } from 'react-redux';
import RecipeItem from '../components/recipes/RecipeItem';
import { fetchRecipes } from '../actions/RecipeAction';
import { isAuthenticated } from '../utils/AuthUtils';

class Home extends Component {
  componentDidMount() {
    if (isAuthenticated()) {
      this.props.fetchRecipes();
    }
  }

  render() {
    return (
      <div className="home">
        {isAuthenticated() ? this.renderRecipes() : "Hello World"}
      </div>
    )
  }

  renderRecipes() {
    return <div className="row">
      {this.props.recipes.map((recipe) => {
        return <RecipeItem key={recipe.id} recipe={recipe} />
      })}
    </div>
  }
}

function mapStateToProps(state) {
  return {
    recipes: state.recipes
  }
}

export default connect(mapStateToProps, { fetchRecipes })(Home);
