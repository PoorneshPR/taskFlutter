import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_flutter/Models/ContactsModel.dart';
import 'package:task_flutter/Models/ProductMap.dart';
import 'package:task_flutter/Models/ecommercemodels.dart';

class DbConnection {
  DbConnection._createInstance();

  static final DbConnection instance = DbConnection._createInstance();
  static Database? _database;

  static const _databaseName = "task_Database.db";
  static const _tableName = "task_Table";
  static const _productsTable = "products_Table";
  static const _id = "id";
  static const _productNameid = "id";
  static const _contact = "contact";
  static const _product = "product";
  static const _databaseVersion = 1;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<void> get initDatabase async {
    return await _initDatabase();
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const create = "CREATE TABLE $_tableName("
        "$_id INTEGER PRIMARY KEY,"
        "$_contact TEXT NOT NULL)";

    await db.execute(create);
    const createProductTable = "CREATE TABLE $_productsTable("
        "$_productNameid TEXT NOT NULL,"
        "$_product TEXT NOT NULL)";

    await db.execute(createProductTable);
  }

  Future<void> insertIntoContacts(ContactsModel? contact) async {
    var contactValue = contact?.toJson();

    String _jsondata = jsonEncode(contactValue);

    Map<String, dynamic> _insertValues = {_contact: _jsondata};

    Database? db = await database;
    //instance of the same database we created

    await db?.insert(_tableName, _insertValues,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ContactsModel>?> getContacts() async {
    Database? db = await database;

    final List<Map<String, dynamic>>? maps = await db?.query(
      _tableName,
    );
    if (maps != null && maps.isNotEmpty) {
      return List.generate(maps.length,
          (index) => ContactsModel.fromJson(jsonDecode(maps[index][_contact])));
    }
    return null;
  }

  Future<void> insertIntoProductCart(Value? productModel) async {
    var productValue = productModel?.toJson();
    String _jsondata = jsonEncode(productValue);
    Map<String, dynamic> _insertValues = {
      _product: _jsondata,_productNameid:productModel?.id
    };
    Database? db = await database;
    await db?.insert(_productsTable, _insertValues,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Value>?> getEcommerceProducts() async {
    Database? db = await database;

    final List<Map<String, dynamic>>? maps = await db?.query(
      _productsTable,
    );

    if (maps != null && maps.isNotEmpty) {
      // return ProductValue()
      return List.generate(maps.length,
          (index) => Value.fromJson(jsonDecode(maps[index][_product])));
    }
    return null;
  }

  // Future getAllClients() async {
  //   final db = await database;
  //   var res = await db?.query(_productsTable);
  //   var list =
  //       res!.isNotEmpty ? res.map((e) => ProductMap.fromMap(e)).toList() : [];
  //   return await list;
  // }

  //delete all function
  deleteAllData() async {
    Database? db = await database;
    return await db?.delete(_productsTable);
  }

  deleteOneItem(int? index) async {
    Database? db = await database;
    return await db?.delete(
      _productsTable,
      where: "$_productNameid = ?",
      whereArgs: [index],
    );
  }
}
