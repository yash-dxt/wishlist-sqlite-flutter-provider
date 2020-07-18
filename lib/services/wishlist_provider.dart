import 'package:flutter/cupertino.dart';
import 'package:wishlist/wishlist_model.dart';
import 'wishlist_database.dart';

class WishListProvider with ChangeNotifier {
  List<WishList> wishList = [];

  int get wishListCount {
    return wishList.length;
  }

  void fetchWishList() {
    WishListDatabase.db.getFullWishList().then((value) {
      wishList = value;
      notifyListeners();
    });
  }

  void addNewWishList({int price, String product}) {
    WishListDatabase.db.addToDatabase(WishList(price: price, product: product));
    fetchWishList();

    print(wishListCount);
  }

  void removeFromWishList(int id) {
    WishListDatabase.db.deleteWishListWithId(id);
    print(wishListCount);
    fetchWishList();
  }

  void removeAll() {
    WishListDatabase.db.deleteAll();
    fetchWishList();
  }

  void updateWishList({int price, String product, int id}) {
    WishListDatabase.db
        .updateWish(WishList(price: price, product: product, id: id));
    fetchWishList();
  }
}
