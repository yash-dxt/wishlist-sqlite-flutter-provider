import 'package:flutter/material.dart';
import 'package:wishlist/services/wishlist_database.dart';
import '../wishlist_model.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final database = WishListDatabase.db;
  int price;
  String product;

  @override
  Widget build(BuildContext context) {
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
                    child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text('New Wish', style: TextStyle(fontSize: 20)),
                        SizedBox(
                          height: 30,
                        ),
                        TextField(
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
                        TextField(
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
                                  setState(() {
                                    database.addToDatabase(WishList(
                                        price: price, product: product));
                                  });
                                  Navigator.pop(context);
                                })
                          ],
                        )
                      ],
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
            setState(() {
              database.deleteAll();
            });
          },
          child: Icon(Icons.delete),
        )
      ]),
      body: FutureBuilder<List<WishList>>(
          future: database.getFullWishList(),
          builder:
              (BuildContext context, AsyncSnapshot<List<WishList>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    WishList element = snapshot.data[index];
                    return ListTile(
                      onTap: () {
                        int priceOfElement = element.price;
                        String previousProduct = element.product;
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.all(15),
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
                                    TextField(
                                      onChanged: (value) {
                                        product = value;
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: '$previousProduct',
                                        helperText: 'Enter the product!',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    TextField(
                                      onChanged: (value) {
                                        price = int.parse(value);
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: '$priceOfElement',
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
                                              setState(() {
                                                database.updateWish(WishList(
                                                    price: price,
                                                    product: product,
                                                    id: element.id));
                                              });
                                              Navigator.pop(context);
                                            })
                                      ],
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      onLongPress: () {
                        setState(() {
                          database.deleteWishListWithId(element.id);
                        });
                      },
                      title: Text(element.product),
                      subtitle: Text(element.price.toString()),
                      leading: Text((index + 1).toString()),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
