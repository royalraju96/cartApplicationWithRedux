import 'package:cart_application/controller/CartController.dart';
import 'package:cart_application/redux/state/app_state.dart';
import 'package:cart_application/view/check_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ShopItem extends StatelessWidget {
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
              "Shopping Cart",
              style: TextStyle(color: Colors.black),
            ),
            floating: true,
            actions: [
              IconButton(
                icon: Column(
                  children: [
                    Icon(Icons.shopping_basket_sharp),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckOut(),
                      ));
                },
              )
            ],
          ),
          SliverFillRemaining(
            child: StoreConnector<AppState, Store>(
                converter: (store) => store,
                builder: (context, store) {
                  AppState appState = store.state;
                  if (appState?.rxShopModel?.data != null) {
                    return ListView.builder(
                      itemCount: appState.rxShopModel.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var value = appState.rxShopModel.data;
                        return Card(
                          elevation: 3.0,
                          /* Expandable Tile  */
                          child: ExpansionTile(
                            title: Text(value[index].title),
                            subtitle: Text("\u20B9${value[index].price}"),
                            leading: Hero(
                              tag: "New Image$index",
                              child: Image.network(value[index].featuredImage),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add_shopping_cart_outlined),
                              onPressed: () {
                                CartController.addItems(
                                    store: store,
                                    id: value[index].id.toString(),
                                    description: value[index].description,
                                    price: value[index].price,
                                    qty: value[index].qty,
                                    title: value[index].title,
                                    imageUrl: value[index].featuredImage);
                              },
                            ),
                            children: [
                              ListTile(title: Text(value[index].description)),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
