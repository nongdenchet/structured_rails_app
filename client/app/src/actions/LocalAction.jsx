import { setLocale, loadTranslations } from 'react-redux-i18n';
import translation from '../utils/Translation';

export function changeLocale(local) {
  return function (dispatch) {
    dispatch(loadTranslations(translation));
    dispatch(setLocale(local));
  }
}