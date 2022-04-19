import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:task_flutter/Services/ContactsService.dart';
import '../../DbHelper/DbConnection.dart';
import '../../models/ContactsModel.dart';

class DbProvider with ChangeNotifier {
  final DbConnection _db = DbConnection.instance;

  ContactsList? _lists;
  List<ContactsModel>? contactUser;
  List<ContactsModel>? initialData;

  ContactsList? get lists => _lists;

  set lists(ContactsList? lists) {
    _lists = lists;
    notifyListeners();
  }

  Future<String?> _loadApiData() async {
    return await ContactsService().getApiData();
  }

  Future<void> loadContacts() async {
    contactUser = await _db.getContacts();
    initialData = await _db.getContacts();
    debugPrint('length ${contactUser?.length}');
    if (contactUser == null || contactUser!.isEmpty) {
      String? jsonString = await _loadApiData();
      final jsonResponse = json.decode(jsonString!);
      ContactsList data = ContactsList.fromJson(jsonResponse);
      data.contactList?.forEach((element) async {
        await _db.insertIntoContacts(element);
      });
      contactUser = await _db.getContacts();

    }
    print(contactUser?.toList());
    notifyListeners();
  }
  Future<void>filterdata(String query)async {
    if(query.isNotEmpty){
      contactUser = contactUser?.where((element) => element.username.toLowerCase().contains(query.toLowerCase())).toList();
      notifyListeners();
    }else{
      contactUser =initialData;
      notifyListeners();
    }
  }


}
