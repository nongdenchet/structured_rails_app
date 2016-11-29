import { RECIPES } from './Types';
import axios from 'axios';
import { authFromLocal } from '../utils/AuthUtils';

export function fetchRecipes() {
  return function (dispatch) {
    axios.get('/recipes/feeds', { headers: authFromLocal() })
      .then(response => {
        dispatch({ type: RECIPES, payload: response.data.recipes });
      })
  }
}