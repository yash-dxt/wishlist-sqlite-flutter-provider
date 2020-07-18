import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/screens/wishlist_screen.dart';
import 'package:wishlist/services/wishlist_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => WishListProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WishListScreen(),
      ),
    );
  }
}
