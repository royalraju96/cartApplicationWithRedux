import 'dart:convert';

import 'package:cart_application/model/PostRequestModel.dart';
import 'package:cart_application/model/shop_model.dart';
import 'package:cart_application/redux/action/actions.dart';
import 'package:cart_application/res/AppString.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

class ShopDataAPICall {
  static getShopData(Store store, int page) async {
    PostRequestModel postRequestModel =
        PostRequestModel(page: 1, perPage: page);

    var body = jsonEncode(postRequestModel);
    await http
        .post(
      AppString.shopUrl,
      headers: {
        "content-type": "Application/json",
        "token":
            "eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz"
      },
      body: body,
    )
        .then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var json = jsonDecode(response.body);
        ShopModel data = ShopModel.fromJson(json);

        store.dispatch(ShopAction(data));
      }
    }).catchError((e) {
      print("$e");
    });
  }
}
