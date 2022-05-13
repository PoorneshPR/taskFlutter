import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_flutter/Models/ContactsModel.dart';
import 'package:task_flutter/Models/ProductMapModels.dart';
import 'package:task_flutter/Models/ecommercemodels.dart';

class DbConnection {
  DbConnection._createInstance();

  static final DbConnection instance = DbConnection._createInstance();
  static Database? _database;

  static const _databaseName = "task_Database.db";
  static const _tableName = "task_Table";
  static const _productsTable = "products_Table";
  static const _productsTableId = "productsTableId";
  static const _id = "id";
  static const _productNameid = "id";
  static const _contact = "contact";
  static const _product = "product";
  static const _productCount = "productCount";
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

    await db.execute(
        "CREATE TABLE $_productsTable($_productsTableId INTEGER PRIMARY KEY,$_product TEXT,$_productCount INTEGER)");
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

    List<ProductMapModels>? getList = await getEcommerceProducts();
    final check = getList?.firstWhere(
        (element) => element.product?.id == productModel?.id,
        orElse: () => ProductMapModels());
    if (check?.product != null) {
      int? _count = check?.quantityCount ?? 0;
      _count = _count + 1;
      print(_count);
      await updateOneItem(_count,check?.productTableId);
   //   print(await updateOneItem(_count ));
    } else {
      Map<String, dynamic> _insertValues = {
        _product: _jsondata,
        _productCount: 1
      };
      Database? db = await database;
      await db?.insert(_productsTable, _insertValues,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<ProductMapModels>?> getEcommerceProducts() async {
    Database? db = await database;

    final List<Map<String, dynamic>>? maps =
        await db?.rawQuery('SELECT * FROM $_productsTable');
    // if (maps != null && maps.isNotEmpty) {
    var lisProductCart =
        maps?.map((e) => ProductMapModels.fromjson(e)).toList();

    return lisProductCart;
    // }
    // return null;
  }

  //delete all function
  deleteAllData() async {
    Database? db = await database;
    return await db?.delete(_productsTable);
  }

  deleteOneItem(int index) async {
    Database? db = await database;
    return await db!.rawDelete(
        "DELETE FROM $_productsTable WHERE $_productsTableId = $index");
  }

  updateOneItem(
    int? index,int? id
  ) async {
    Database? db = await database;
    return await db!
        .rawUpdate("UPDATE  $_productsTable SET $_productCount =$index WHERE $_productsTableId = $id");
    // return await db?.delete(_productsTable,where: _productsTableId,whereArgs: [index]);
  }

  totalCountCart() async {
    Database? db = await database;
    return await db!
        .rawQuery("SELECT SUM($_productCount) FROM $_productsTable;");
  }
}
