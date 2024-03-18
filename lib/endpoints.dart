import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;

const String BASEURL = 'http://10.0.2.2/notes';
// authentication
const String LOGIN = '$BASEURL/auth/login.php';
const String SIGNUP = '$BASEURL/auth/signup.php';
// end auth;
// notes
const String NOTES = '$BASEURL/apis/get_notes.php';
const String ADD_NOTE = '$BASEURL/apis/add_note.php';
const String UPDATE_NOTE = '$BASEURL/apis/update_note.php';
const String DELETE_NOTE = '$BASEURL/apis/delete_note.php';

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
      } else if (response.statusCode != 200) {
        print('Error ${response.statusCode}');
      } else {
        print('Failed Error Server');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // upload any type of data
  Future<dynamic> postMultiRequest(
      String url, Map data, File? file, String namefield) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // إذا كان الملف موجودًا، أضفه إلى الطلب
    if (file != null) {
      var length = await file.length();
      var stream = http.ByteStream(file.openRead());
      var filename = basename(file.path); // استيراد المكتبة path
      var multipartFile =
          http.MultipartFile(namefield, stream, length, filename: filename);

      request.files.add(multipartFile);
    }

    // أضف باقي البيانات إلى الحقول
    data.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // أرسل الطلب
    var myRequest = await request.send();

    // استقبل الرد
    var response = await http.Response.fromStream(myRequest);

    // فحص حالة الرد
    if (myRequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error ${myRequest.statusCode}');
    }
  }
}
