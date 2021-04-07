import 'package:cart_application/redux/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent.withOpacity(0.2),
            elevation: 4.0,
            centerTitle: true,
            title: Text(
              "Check Out",
              style: TextStyle(color: Colors.black),
            ),
            floating: true,
          ),
          SliverFillRemaining(
            child: StoreConnector<AppState, Store>(
                onInit: (store) => totalAmounts(store),
                onDidChange: (store) => totalAmounts(store),
                converter: (store) => store,
                builder: (context, store) {
                  AppState appState = store.state;

                  return Column(
                    children: [
                      Card(
                        margin: EdgeInsets.all(15),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              Spacer(),
                              Chip(
                                label: Text(
                                  "\u20B9$totalAmount",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30.0),
                                ),
                              ),
                              FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      clear(store);
                                    });
                                  },
                                  child: Text("Clear All")),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: appState.rxShopModel.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ExpansionTile(
                                leading: Hero(
                                  tag: "$index",
                                  child: Image.network(appState
                                      .rxShopModel.items.values
                                      .toList()[index]
                                      .featuredImage),
                                ),
                                title: Text(appState.rxShopModel.items.values
                                    .toList()[index]
                                    .title),
                                subtitle: Row(
                                  children: [
                                    Text(
                                        "\u20B9${appState.rxShopModel.items.values.toList()[index].price * appState.rxShopModel.items.values.toList()[index].qty}"),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                        "${appState.rxShopModel.items.values.toList()[index].qty}x"),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    removeItems(
                                        store,
                                        appState.rxShopModel.items.values
                                            .toList()[index]
                                            .id);
                                  },
                                ),
                                children: [
                                  Text(appState.rxShopModel.items.values
                                          .toList()[index]
                                          .description ??
                                      "")
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  /* Remove Items */
  void removeItems(Store store, int id) {
    AppState appState = store.state;

    if (appState.rxShopModel.items.containsKey(id.toString())) {
      setState(() {
        appState.rxShopModel.items.remove(id.toString());
      });
    }
  }

/* Total Amount */
  totalAmounts(Store store) {
    AppState appState = store.state;
    appState.rxShopModel.items.forEach((key, cartItem) {
      totalAmount += cartItem.price * cartItem.qty;
    });
  }

  /* Remove Product */
  clear(Store store) {
    AppState appState = store.state;
    appState.rxShopModel.items.clear();
    setState(() {
      totalAmount = 0;
    });
  }
}
