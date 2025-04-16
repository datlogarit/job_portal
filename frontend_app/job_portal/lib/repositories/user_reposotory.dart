import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:job_portal/models/user_model.dart';

class UserReposotory {
  // final Map<String, dynamic> content;
  UserReposotory();
  static dynamic login(String email, String password, String role) async {
    Uri url = Uri.parse("http://10.0.2.2:8088/api/v1/user/login/$role");
    var data = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
    var formatUtf8 = utf8.decode(data.bodyBytes); //
    Map<String, dynamic> dataObj = jsonDecode(formatUtf8);

    if (data.statusCode == 200) {
      print("login successfully");
      print(dataObj);
    } else {
      print("login false ${data.statusCode}, ${data.body}");
      throw Exception(dataObj['message']);
    }
    return dataObj;
  }

  static dynamic registerApplicant(
      String fullname, String email, String password) async {
    Uri url = Uri.parse("http://10.0.2.2:8088/api/v1/applicant");
    var data = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'name': fullname,
          'email': email,
          'password': password,
        },
      ),
    );
    print("in repo: registering");
    print("name: $fullname");
    print("email: $email");
    print("password: $password");
    if (data.statusCode == 200) {
      print("register successfully");
      return true;
    } else {
      String utf8Body =
          utf8.decode(data.bodyBytes); //giải mã dữ liệu từ mảng byte thành UTF8
      String content = jsonDecode(utf8Body)['message']; //chuyển từ json về map

      throw Exception(content); //ném ra ngoại lệ và bắt ở UI
    }
  }

  static Future<User> getUserbyId(int userId) async {
    String url = 'http://10.0.2.2:8088/api/v1/user/$userId';
    var data = await http.get(Uri.parse(url)); //json
    String dataUtf8 = utf8.decode(data.bodyBytes); //có dạng utf8
    Map<String, dynamic> objDart =
        jsonDecode(dataUtf8); //đưa nó về dạng đối tượng dart Map, List,...
    User user = User.fromJson(objDart);
    print("${user.name}");
    return user;
  }

  static Future<void> updateUserById(int userId, String? name, String? password,
      String? phoneNumber, String? birthDay) async {
    String url = 'http://10.0.2.2:8088/api/v1/user/$userId';
    var data = await http.put(Uri.parse(url),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "password": password,
          "phone_number": phoneNumber,
          "dob": birthDay
        })); //json
    if (data.statusCode == 200 || data.statusCode == 201) {
      print(data.body);
    } else {
      //co data dang json

      var utf8Body = utf8.decode(data.bodyBytes);
      var objDart = jsonDecode(utf8Body);
      throw Exception(objDart['message']);
      // print(data.body);
    }
  }
}
