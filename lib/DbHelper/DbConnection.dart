import 'dart:convert';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:task_flutter/models/ContactsModel.dart';
import 'package:task_flutter/Services/ContactsService.dart';

class DbConnection {
  DbConnection._createInstance();

  static final DbConnection instance = DbConnection._createInstance();
  static Database? _database;

  static const _databaseName = "task_Database.db";
  static const _tableName = "task_Table";
  static const _id = "id";
  static const _contact = "contact";
  static const _databaseVersion = 1;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
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
  }

  Future<void> insertIntoContacts(ContactsModel contact) async {
    var contactValue = contact.toJson();

    String _jsondata = jsonEncode(contactValue);

    Map<String, dynamic> _insertValues = {_contact: _jsondata};

    Database? db = await database;
    //instance of the same database we created

    await db?.insert(_tableName, _insertValues,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ContactsModel>> getContacts({String? query}) async {
    Database? db = await database;

    final List<Map<String, dynamic>> maps = await db!.query(
      _tableName,
    );
    if (query != null) {
      return ContactsService().fetchData(query: query);
    }
    return List.generate(maps.length,
        (index) => ContactsModel.fromJson(jsonDecode(maps[index][_contact])));
  }
}
