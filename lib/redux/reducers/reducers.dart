import 'package:cart_application/redux/action/actions.dart';
import 'package:cart_application/redux/state/app_state.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromState(prevState);
  if (action is ShopAction) {
    newState.shopModel = action.payload;
  }

  return newState;
}
