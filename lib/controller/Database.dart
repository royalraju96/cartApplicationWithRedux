import 'dart:io';

// import 'package:cart_application/model/DatabaseModel.dart';
import 'package:cart_application/model/shop_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

final String tableName = 'CartTable';
final String columnId = 'id';
final String price = 'price';
final String title = 'title';
final String quantity = 'qty';
final String featuredImage = 'featured_image';

class DbProvider {
  DbProvider._();
  static final DbProvider db = DbProvider._();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    /* If database is null we initialize it */
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "CartsDB.db");
    print("database is created");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(''' 
      CREATE TABLE $tableName (
        $columnId integer primary key,
        $quantity integer not null,
        $title text not null,
        $price integer not null,
        $featuredImage text)
      ''');
    });
  }

  getClient(int id) async {
    final db = await database;
    var res = await db.query("Cart", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Data.fromJson(res.first) : Null;
  }

  newCart(Data newCart) async {
    final db = await database;
    var res = await db.rawInsert("INSERT Into Cart (id ,qty)"
        " VALUES (${newCart.id},${newCart.qty})");
    return res;
  }

/* Insert Data to db */
  insertToDb(Map<String, dynamic> newCart, int id) async {
    final db = await database;
    var result = await db.query("$tableName", where: "id = ?", whereArgs: [id]);
    print(result);
    var val = result.isEmpty
        ? result.isEmpty
        : result.isEmpty && result[0]['id'] != id;
    if (val) {
      try {
        var res = db.insert(tableName, newCart);
        return res;
      } catch (e, s) {
        print("$s");
        print("$e");
      }
    } else {
      print("Id is available");
      updateExistingCart(newCart);
      getAllCarts();
    }
  }

  getAllCarts() async {
    final db = await database;
    var res = await db.query("$tableName");
    print(res);
    // return list;
  }

/* Update item */
  updateExistingCart(Map<String, dynamic> newCart) async {
    print(newCart);
    final db = await database;
    print(newCart);
    var res = await db.update("$tableName", newCart,
        where: "id = ? ", whereArgs: [newCart['id']]);

    return res;
  }

  /* Delete Cart */
  deleteCart(int id) async {
    final db = await database;
    var val = db.delete("$tableName", where: "id = ?", whereArgs: [id]);
    print(val);
    return val;
  }

  /* Delete all Cart */
  deleteAllCart() async {
    final db = await database;
    db.rawDelete("Delete * from $tableName");
  }
}
