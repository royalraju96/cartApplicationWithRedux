import 'package:cart_application/controller/Database.dart';
import 'package:cart_application/model/shop_model.dart';
import 'package:cart_application/redux/action/actions.dart';

import 'package:redux/redux.dart';
import 'package:sqflite/sqflite.dart';

class CartController {
  /* Add the product to the cart */
  static int totalAmount = 0;
  static Map<String, Data> item = {};

  static void addItems(
      {Store store,
      String id,
      String title,
      String description,
      int qty,
      int price,
      String imageUrl}) {
    if (item.containsKey(id)) {
      item.update(id.toString(), (existingCartItem) {
        Map<String, dynamic> toJson() {
          final Map<String, dynamic> data = new Map<String, dynamic>();
          data['id'] = existingCartItem.id;
          data['qty'] = existingCartItem.qty;
          data['title'] = existingCartItem.title;
          data['price'] = existingCartItem.price * existingCartItem.qty;
          data['featured_image'] = existingCartItem.featuredImage;
          return data;
        }

        store.dispatch(CartDataAction(item));
        DbProvider.db.insertToDb(toJson(), existingCartItem.id);
        return Data(
            id: existingCartItem.id,
            qty: existingCartItem.qty + 1,
            title: existingCartItem.title,
            price: existingCartItem.price,
            featuredImage: existingCartItem.featuredImage);
      });
    } else {
      item.putIfAbsent(
          id.toString(),
          () => Data(
              id: int.tryParse(id),
              price: price,
              title: title,
              description: description,
              featuredImage: imageUrl,
              qty: qty));
      store.dispatch(CartDataAction(item));
    }
  }

  /* Remove Items */
  static void removeItems(Store store, int id) {
    if (item.containsKey(id.toString())) {
      item.remove(id.toString());
      DbProvider.db.deleteCart(id);
      store.dispatch(CartDataAction(item));
    }
  }

  /* Remove Product */
  static clear(Store store) {
    item.clear();
    store.dispatch(CartDataAction({}));
    DbProvider.db.deleteAllCart();
    totalAmount = 0;
    store.dispatch(TotalAmountAction(totalAmount));
  }
}
