import 'package:cart_application/controller/CartController.dart';
import 'package:cart_application/redux/action/actions.dart';
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
  /* Total Amount */
  totalAmounts(Store store) {
    int index = 0;
    print("I m called ${index++}");
    AppState appState = store.state;
    appState.rxCartData.forEach((key, cartItem) {
      totalAmount += cartItem.price * cartItem.qty;

      return totalAmount;
    });

    store.dispatch(TotalAmountAction(totalAmount));
  }

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
              onInit: (store) {
                totalAmounts(store);
              },
              converter: (store) => store,
              builder: (context, store) {
                AppState appState = store.state;
                print(appState.rxTotalAmount);
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
                                "\u20B9${appState.rxTotalAmount}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 30.0),
                              ),
                            ),
                            FlatButton(
                                onPressed: () {
                                  CartController.clear(store);
                                },
                                child: Text("Clear All")),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: appState.rxCartData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ExpansionTile(
                              leading: Hero(
                                tag: "$index",
                                child: Image.network(appState.rxCartData.values
                                    .toList()[index]
                                    .featuredImage),
                              ),
                              title: Text(appState.rxCartData.values
                                  .toList()[index]
                                  .title),
                              subtitle: Row(
                                children: [
                                  Text(
                                      "\u20B9${appState.rxCartData.values.toList()[index].price * appState.rxCartData.values.toList()[index].qty}"),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                      "${appState.rxCartData.values.toList()[index].qty}x"),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  CartController.removeItems(
                                      store,
                                      appState.rxCartData.values
                                          .toList()[index]
                                          .id);
                                },
                              ),
                              children: [
                                Text(appState.rxCartData.values
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
              },
            ),
          )
        ],
      ),
    );
  }
}
