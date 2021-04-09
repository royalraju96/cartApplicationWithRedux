import 'package:cart_application/controller/CartController.dart';
import 'package:cart_application/model/shop_model.dart';

class AppState {
  ShopModel shopModel;
  CartController cartController;
  int totalAmount = 0;
  Map<String, Data> cartData = {};

  AppState({
    this.shopModel,
    this.cartController,
    this.totalAmount,
    this.cartData,
  });

  AppState.fromState(AppState appState) {
    shopModel = appState.shopModel;
    cartController = appState.cartController;
    totalAmount = appState.totalAmount;
    cartData = appState.cartData;
  }

  ShopModel get rxShopModel => shopModel;

  CartController get rxCartController => cartController;

  int get rxTotalAmount => totalAmount;

  Map<String, Data> get rxCartData => cartData;
}
