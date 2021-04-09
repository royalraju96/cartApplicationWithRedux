import 'package:cart_application/controller/CartController.dart';
import 'package:cart_application/model/shop_model.dart';

class ShopAction {
  final ShopModel payload;
  ShopAction(this.payload);
}

class CartControllerAction {
  final CartController payload;
  CartControllerAction(this.payload);
}

class TotalAmountAction {
  final int payload;
  TotalAmountAction(this.payload);
}

class CartDataAction {
  final Map<String, Data> payload;
  CartDataAction(this.payload);
}
