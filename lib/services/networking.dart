import 'dart:html';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future GetData() async {
    var Url = Uri.parse(url);
    http.Response response = await http.get(Url);
    if (response.statusCode == 200) {
      var decodedData = convert.jsonDecode(response.body);
      return decodedData;
    }
  }
}
