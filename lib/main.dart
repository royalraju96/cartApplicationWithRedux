import 'package:cart_application/controller/APICall.dart';
import 'package:cart_application/redux/reducers/reducers.dart';
import 'package:cart_application/redux/state/app_state.dart';
import 'package:cart_application/view/shop_items.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final _initialState = AppState();
  final Store<AppState> _store = Store<AppState>(
    reducer,
    middleware: [thunkMiddleware],
    initialState: _initialState,
  );
  runApp(MyApp(
    store: _store,
  ));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;

  const MyApp({Key key, this.store}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StoreConnector<AppState, Store>(
            onInit: (store) => ShopDataAPICall.getShopData(store),
            converter: (store) => store,
            builder: (context, store) {
              return ShopItem();
            }),
      ),
    );
  }
}
