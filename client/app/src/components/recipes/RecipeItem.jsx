import React, {Component} from 'react';

class RecipeItem extends Component {
  render() {
    const recipe = this.props.recipe;
    return (
      <div className="col-sm-6 col-md-4 recipe-item">
        <div className="thumbnail">
          <img src={recipe.image.url}/>
          <div className="caption">
            <h3>{recipe.title}</h3>
            <p>{recipe.description}</p>
          </div>
        </div>
      </div>
    )
  }
}

export default RecipeItem;
