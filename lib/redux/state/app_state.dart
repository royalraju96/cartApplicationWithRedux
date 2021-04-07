import 'package:cart_application/model/shop_model.dart';

class AppState {
  ShopModel shopModel;

  AppState({
    this.shopModel,
  });

  AppState.fromState(AppState appState) {
    shopModel = appState.shopModel;
  }

  ShopModel get rxShopModel => shopModel;
}
