import 'package:http/http.dart' as http;
import 'package:task_flutter/models/ContactsModel.dart';

class ContactsService {



  Future<String?> getApiData() async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));

      if (response.statusCode == 200) {
        final jsonString = response.body;
        client.close();
        return jsonString;
      } else {
        throw "failed to load data";
      }
    } catch (err) {
      client.close();
      return null;
    }
  }
}
