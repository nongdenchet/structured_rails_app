import { RECIPES } from '../actions/Types';

export default function (state = [], action) {
  if (action.type == RECIPES) {
    return action.payload;
  }
  return state;
}
