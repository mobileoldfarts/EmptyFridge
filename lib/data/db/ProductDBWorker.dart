import 'package:empty_fridge/entities/ProductListItem.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductDBWorker {
  ProductDBWorker._();

  static final ProductDBWorker db = ProductDBWorker._();

  Database _db;

  Future get database async {
    if (_db == null) {
      _db = await init();
    }
    return _db;
  }

  Future<Database> init() async {
    String path = join(await getDatabasesPath(), "products.db");
    Database db = await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database inDB, int inVersion) async {
      await inDB.execute("CREATE TABLE IF NOT EXISTS products ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "isPurchased INTEGER"
          ")");
    });
    return db;
  }

  Future<List<ProductListItem>> getAllProduct() async {
    Database db = await database;

    var mapProducts = await db.query("products");

    return mapProducts.isNotEmpty ? mapProducts.map((it) => ProductListItem.fromMap(it)).toList() : List<ProductListItem>();
  }

  Future create(ProductListItem item) async {
    Database db = await database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM products");
    int id = val.first["id"];
    if (id == null) {
      id = 1;
    }
    return await db.rawInsert(
        "INSERT INTO products (id, name, isPurchased) "
        "VALUES (?, ?, ?)",
        [id, item.product.name, item.isPurchased ? 1 : 0]);
  }
}
