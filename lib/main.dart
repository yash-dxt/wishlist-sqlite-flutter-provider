import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/screens/wishlist_screen.dart';
import 'package:wishlist/services/wishlist_database.dart';
import 'package:wishlist/wishlist_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WishListScreen(),
    );
  }
}
