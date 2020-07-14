import 'dart:core';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wishlist/wishlist_model.dart';
import 'dart:async';

class WishlistDatabase {
  WishlistDatabase._();

  static final WishlistDatabase db = WishlistDatabase._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "wishlist.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE WishList("
          "index integer primary key AUTOINCREMENT,"
          "price integer,"
          "product TEXT"
          ") ");
    });
  }

  Future<int> addToDatabase(WishList wishList) async {
    final db = await database;
    var a = db.insert("WishList", wishList.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return a;
  }

  Future<WishList> getWishListByIndex(int index) async {
    final db = await database;
    var response =
        await db.query("WishList", where: "index = ?", whereArgs: [index]);
    return response.isNotEmpty ? WishList.fromMap(response.first) : null;
  }

  Future<List<WishList>> getFullWishList() async {
    final db = await database;
    var response = await db.query("WishList");
    List<WishList> list = response.map((e) => WishList.fromMap(e));
    return list;
  }

  Future<int> deleteWishListWithId(int index) async {
    final db = await database;
    return db.delete("WishList", where: "index = ?", whereArgs: [index]);
  }

  void deleteAll() async {
    final db = await database;
    db.delete("WishList");
  }
}
