import 'package:flutter/material.dart';
import 'package:wishlist/screens/wishlist_screen.dart';

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
