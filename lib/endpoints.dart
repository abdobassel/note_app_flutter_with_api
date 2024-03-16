import 'dart:convert';

import 'package:http/http.dart' as http;

const String BASEURL = 'http://10.0.2.2/notes';
const String LOGIN = '$BASEURL/auth/login.php';
const String SIGNUP = '$BASEURL/auth/signup.php';
Map<String, String> headers = {
  'Content-Type': 'application/json;charset=UTF-8',
  'Charset': 'utf-8'
};

class Crud {
  get(String url) async {
    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        return responseBody;
      } else {
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  // end get method

  postRequest(String url, Map data) async {
    try {
      var response = await http.post(
        Uri.parse(url),

        body: data, // Convert data to JSON string
      );

      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return responseBody;
      } else {
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
