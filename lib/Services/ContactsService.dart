import 'package:http/http.dart' as http;
import 'package:task_flutter/models/ContactsModel.dart';

class ContactsService {
  static var jsonString;

  Future<List<ContactsModel>> fetchData({String? query}) async {
    var jsonResponse;
    var client = http.Client();
    // final result = await http
    //     .get(Uri.parse("http://www.mocky.io/v2/5d565297300000680030a986"));
    final result = await client.get(Uri.parse(
        'http://www.mocky.io/v2/5d565297300000680030a986')); //here need to call through client to get data as string
    if (result.statusCode == 200) {
      jsonResponse = result.body;
      if (query != null) {
        return contactsModelFromJson(jsonResponse)
            .where((element) =>
                element.username.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } //no need to call decode because client called
      return contactsModelFromJson(jsonResponse);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<String?> getApiData() async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));

      if (response.statusCode == 200) {
        jsonString = response.body;

        return jsonString;
      }
    } catch (err) {}
  }
}
