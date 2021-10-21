import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../../../../utils/mapping_db.dart';

// ignore: avoid_classes_with_only_static_members
/// Database Manager
class DBManager {
  static Database? _db;

  /// Start and return database connection
  static Future<Database> db() async {
    if (_db == null) {
      var path = await getDatabasesPath();
      _db = await openDatabase(
        '$path/test.db',
        onCreate: _onCreate,
        version: 1,
      );
    }

    if (_db == null) {
      throw Exception('error starting database');
    }

    return _db!;
  }

  static Future<FutureOr<void>> _onCreate(Database db, int version) async {
    /// PRODUCTS
    await db.execute('''
      CREATE TABLE ${ProductConstants.tableName} (
        ${ProductConstants.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ProductConstants.description} TEXT NOT NULL,
        ${ProductConstants.image_url} TEXT NOT NULL,
        ${ProductConstants.price} REAL NOT NULL
      )
    ''');
    await db.execute('''INSERT INTO ${ProductConstants.tableName} (${ProductConstants.id}, ${ProductConstants.description}, ${ProductConstants.price}, ${ProductConstants.image_url}) VALUES (1, 'Maça',  2.22, 'https://savegnago.vteximg.com.br/arquivos/ids/623748-600-600/Maca-Iberfrutas-500g-Pacote.jpg?v=637654586356330000')''');
    await db.execute('''INSERT INTO ${ProductConstants.tableName} (${ProductConstants.id}, ${ProductConstants.description}, ${ProductConstants.price}, ${ProductConstants.image_url}) VALUES (2, 'Pêra',  4.99, 'https://savegnago.vteximg.com.br/arquivos/ids/623704-600-600/Pera-Williams-Bandeja-750g.jpg?v=637654585543630000')''');
    await db.execute('''INSERT INTO ${ProductConstants.tableName} (${ProductConstants.id}, ${ProductConstants.description}, ${ProductConstants.price}, ${ProductConstants.image_url}) VALUES (3, 'Banana',  6.14, 'https://savegnago.vteximg.com.br/arquivos/ids/660015-600-600/Banana-Prata-Bandeja-900g.jpg?v=637678769885700000')''');
    await db.execute('''INSERT INTO ${ProductConstants.tableName} (${ProductConstants.id}, ${ProductConstants.description}, ${ProductConstants.price}, ${ProductConstants.image_url}) VALUES (4, 'Abacaxi',  10.22, 'https://savegnago.vteximg.com.br/arquivos/ids/623696-600-600/Abacaxi-Perola-Grande-Unidade.jpg?v=637654585444000000')''');
    await db.execute('''INSERT INTO ${ProductConstants.tableName} (${ProductConstants.id}, ${ProductConstants.description}, ${ProductConstants.price}, ${ProductConstants.image_url}) VALUES (5, 'Manga',  12.00, 'https://savegnago.vteximg.com.br/arquivos/ids/573313-600-600/Manga-Palmer-Bandeja-1-500kg.jpg?v=637582862287200000')''');
    /// CART
    await db.execute('''
      CREATE TABLE ${CartConstants.tableName} (
        ${CartConstants.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${CartConstants.created_date} TEXT NOT NULL,
        ${CartConstants.checkout_date} TEXT NULL
      )
    ''');
    /// CART ITEMS
    await db.execute('''
      CREATE TABLE ${CartItemConstants.tableName} (
        ${CartItemConstants.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${CartItemConstants.qty} INT NOT NULL,
        ${CartItemConstants.product_id} INT NOT NULL,
        ${CartItemConstants.cart_id} INT NOT NULL,
        FOREIGN KEY (${CartItemConstants.product_id}) REFERENCES ${ProductConstants.tableName} (${ProductConstants.id}),
        FOREIGN KEY (${CartItemConstants.cart_id}) REFERENCES ${CartConstants.tableName} (${CartConstants.id})
      )
    ''');
  }
}
