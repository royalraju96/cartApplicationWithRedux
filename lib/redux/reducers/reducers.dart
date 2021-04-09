import 'package:cart_application/redux/action/actions.dart';
import 'package:cart_application/redux/state/app_state.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromState(prevState);
  if (action is ShopAction) {
    newState.shopModel = action.payload;
  } else if (action is CartControllerAction) {
    newState.cartController = action.payload;
  } else if (action is TotalAmountAction) {
    newState.totalAmount = action.payload;
  } else if (action is CartDataAction) {
    newState.cartData = action.payload;
  }

  return newState;
}
