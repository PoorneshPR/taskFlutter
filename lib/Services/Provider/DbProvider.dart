import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_flutter/DbHelper/DbConnection.dart';
import 'package:task_flutter/Models/ProductMapModels.dart';
import 'package:task_flutter/Models/ecommercemodels.dart';
import 'package:task_flutter/Services/ContactsService.dart';
import 'package:task_flutter/Models/ContactsModel.dart';
import 'package:provider/provider.dart';

class DbProvider with ChangeNotifier {
  final DbConnection _db = DbConnection.instance;

  // ContactsList? _lists;
  List<ContactsModel>? contactUser;
  List<ContactsModel>? initialData;
  List<ProductMapModels>? productDetails;
  List<Value>? initialProductDetails;
  int cartCount = 0;


  Future<String?> _loadApiData() async {
    return await ContactsService().getApiData();
  }

  Future<void> loadContacts() async {
    contactUser = await _db.getContacts();
    initialData = await _db.getContacts();
    if (contactUser == null || contactUser!.isEmpty) {
      String? jsonString = await _loadApiData();
      List<dynamic> jsonResponse = json.decode(jsonString!);
      List<ContactsModel> data =
          jsonResponse.map((e) => ContactsModel.fromJson(e)).toList();
      data.forEach((element) async {
        await _db.insertIntoContacts(element);
      });
      contactUser = await _db.getContacts();
    }
    notifyListeners();
  }

  Future<void> insertProductToDb(Value? element) async {
    await _db.insertIntoProductCart(element);

    await loadProductsFromDb();
    notifyListeners();
  }

  Future<void> deleteAllProductFromDb() async {
    await _db.deleteAllData();
     loadProductsFromDb();
    notifyListeners();
  }

  Future<void> deleteOneProductFromDb(int id) async {
    await _db.deleteOneItem(id);
        loadProductsFromDb();

    notifyListeners();
  }
   Future<void> loadProductsFromDb() async {
    productDetails = await _db.getEcommerceProducts();
         if (productDetails?.length == null) {
      cartCount = 0;
    } else {
      cartCount = productDetails!.length;
      }


    notifyListeners();
  }

  Future<void> filterdata(String query) async {
    if (query.isNotEmpty) {
      contactUser = contactUser
          ?.where((element) =>
              element.username!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    } else {
      contactUser = initialData;
      notifyListeners();
    }
  }

}
