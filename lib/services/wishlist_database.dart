import 'dart:core';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wishlist/wishlist_model.dart';
import 'dart:async';

class WishListDatabase {
  WishListDatabase._();

  static final WishListDatabase db = WishListDatabase._();
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
      await db.execute("""
      CREATE TABLE WishList(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          price INTEGER,
          product TEXT
          ) """);
    });
  }

  Future<int> addToDatabase(WishList wishList) async {
    final db = await database;
    var a = db.insert("WishList", wishList.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return a;
  }

  Future<WishList> getWishListById(int id) async {
    final db = await database;
    var response = await db.query("WishList", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? WishList.fromMap(response.first) : null;
  }

  Future<List<WishList>> getFullWishList() async {
    final db = await database;
    var response = await db.query("WishList");
    List<WishList> list = response.isNotEmpty
        ? response.map((e) => WishList.fromMap(e)).toList()
        : [];
    return list;
  }

  Future<int> deleteWishListWithId(int id) async {
    final db = await database;
    return db.delete("WishList", where: "id= ?", whereArgs: [id]);
  }

  void deleteAll() async {
    final db = await database;
    db.delete("WishList");
  }

  Future<int> updateWish(WishList wishList) async{
    final db = await database;
    var response = db.update('WishList', wishList.toMap(), where: 'id = ?', whereArgs: [wishList.id]);
    return response;
  }
}
