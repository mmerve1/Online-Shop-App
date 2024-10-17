import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../JSON/users.dart';
import '../Views/Cart.dart';

class DatabaseHelper {
  final databaseName = "auth.db";

  // User table creation SQL statement
  String userTable = '''
   CREATE TABLE users (
   usrId INTEGER PRIMARY KEY AUTOINCREMENT,
   fullName TEXT,
   email TEXT,
   usrName TEXT UNIQUE,
   usrPassword TEXT
   )
   ''';

  // Cart table creation SQL statement
  String cartTable = '''
   CREATE TABLE cart (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   productId TEXT,
   productName TEXT,
   productPrice TEXT,
   initialPrice TEXT,
   quantity INTEGER,
   unitTag TEXT,
   image TEXT
   )
   ''';

  // Initialize the database
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute(userTable);
      await db.execute(cartTable);
    });
  }

  // Function methods for User authentication

  Future<bool> authenticate(Users usr) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "select * from users where usrName = '${usr.usrName}' AND usrPassword = '${usr.password}' ");
    return result.isNotEmpty;
  }

  Future<int> createUser(Users usr) async {
    final Database db = await initDB();
    return db.insert("users", usr.toMap());
  }

  Future<Users?> getUser(String usrName) async {
    final Database db = await initDB();
    var res =
        await db.query("users", where: "usrName = ?", whereArgs: [usrName]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }

  // Cart functionality

  Future<int> addToCart(Cart cart) async {
    final Database db = await initDB();
    return db.insert("cart", cart.toMap());
  }

  Future<int> updateCart(Cart cart) async {
    final Database db = await initDB();
    return db
        .update("cart", cart.toMap(), where: "id = ?", whereArgs: [cart.id]);
  }

  Future<int> removeFromCart(int id) async {
    final Database db = await initDB();
    return db.delete("cart", where: "id = ?", whereArgs: [id]);
  }

  Future<List<Cart>> getCartItems() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('cart');
    return List.generate(maps.length, (i) {
      return Cart.fromMap(maps[i]);
    });
  }
}
