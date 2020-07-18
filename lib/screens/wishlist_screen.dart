import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/services/wishlist_provider.dart';
import '../wishlist_model.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  int price;
  String product;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<WishListProvider>(
      builder: (BuildContext context, wishListData, Widget child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Your WishList'),
            ),
            floatingActionButton:
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(15),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text('New Wish',
                                    style: TextStyle(fontSize: 20)),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter something';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    product = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Product',
                                    helperText: 'Enter the product!',
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter something';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    price = int.parse(value);
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Price',
                                    helperText: 'Enter the price!',
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FloatingActionButton(
                                        child: Icon(Icons.check),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            wishListData.addNewWishList(
                                                price: price, product: product);
                                            Navigator.pop(context);
                                          }
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  wishListData.removeAll();
                },
                child: Icon(Icons.delete),
              )
            ]),
            body: wishListData.wishList == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: wishListData.wishListCount,
                    itemBuilder: (context, index) {
                      WishList element = wishListData.wishList[index];
                      return ListTile(
                        onTap: () {
                          int priceOfElement = element.price;
                          String previousProduct = element.product;
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsets.all(15),
                                  child: Form(
                                    key: _formKey2,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Update Wish',
                                            style: TextStyle(fontSize: 20)),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        TextFormField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter something';
                                            }
                                            return null;
                                          },
                                          initialValue: '$previousProduct',
                                          onChanged: (value) {
                                            product = value;
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            helperText: 'Enter the product!',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        TextFormField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter something';
                                            }
                                            return null;
                                          },
                                          initialValue: '$priceOfElement',
                                          onChanged: (value) {
                                            price = int.parse(value);
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            helperText: 'Enter the price!',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            FloatingActionButton(
                                                child: Icon(Icons.check),
                                                onPressed: () {
                                                  if (_formKey2.currentState
                                                      .validate()) {
                                                    wishListData.updateWishList(
                                                        price: price,
                                                        product: product,
                                                        id: element.id);
                                                    Navigator.pop(context);
                                                  }
                                                })
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        onLongPress: () {
                          wishListData.removeFromWishList(element.id);
                        },
                        title: Text(element.product),
                        subtitle: Text(element.price.toString()),
                        leading: Text((index + 1).toString()),
                      );
                    }));
      },
    );
  }
}
