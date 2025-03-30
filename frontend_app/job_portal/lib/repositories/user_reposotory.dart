import 'dart:convert';
import 'package:http/http.dart' as http;

class UserReposotory {
  final Map<String, dynamic> content;
  UserReposotory(this.content);
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
      // print("register false $statusCode, $content");
      // return false;
    }
  }
}
