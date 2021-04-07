import 'package:cart_application/model/shop_model.dart';
import 'package:cart_application/redux/state/app_state.dart';

import 'package:redux/redux.dart';

class CartController {
  /* Add the product to the cart */
  static void addItems(
      {Store store,
      String id,
      String title,
      String description,
      int qty,
      int price,
      String imageUrl}) {
    AppState appState = store.state;
    if (appState.rxShopModel.items.containsKey(id)) {
      appState.rxShopModel.items.update(
          id.toString(),
          (existingCartItem) => Data(
              id: existingCartItem.id,
              qty: existingCartItem.qty + 1,
              title: existingCartItem.title,
              price: existingCartItem.price,
              featuredImage: existingCartItem.featuredImage));
    } else {
      appState.rxShopModel.items.putIfAbsent(
          id.toString(),
          () => Data(
              id: int.tryParse(id),
              price: price,
              title: title,
              description: description,
              featuredImage: imageUrl,
              qty: qty));
    }
  }
}
