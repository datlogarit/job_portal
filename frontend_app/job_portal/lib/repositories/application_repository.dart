import 'dart:convert';
import 'dart:io';
import 'package:job_portal/models/application_model.dart';
import 'package:http/http.dart' as http;

class ApplicationRepository {
  static Future<dynamic> createApplication(
      int applicantId,
      int jobId,
      String fullName,
      String email,
      String phoneNumber,
      File cv,
      String message) async {
    String url = 'http://10.0.2.2:8088/api/v1/application';
    var request = http.MultipartRequest("POST", Uri.parse(url))
      ..headers['Content-Type'] = 'multipart/form-data'
      ..files.add(await http.MultipartFile.fromPath("file", cv.path))
      ..fields['info'] = jsonEncode(
        {
          "applicant_id": applicantId,
          "job_id": jobId,
          "status_apply": "applied",
          "full_name": fullName,
          "email": email,
          "phone_number": phoneNumber,
          "message": message
        },
      );
    final respon = await request.send(); // truyền JSON thành String
    final responseBody = await respon.stream.bytesToString(); //đọc respon
    if (respon.statusCode == 200 || respon.statusCode == 201) {
      print(responseBody);
      return true;
    } else {
      print("lỗi ${respon.statusCode} - $responseBody");
      return false;
    }
  }

  static Future<Application> fetchApplication(
      int applicantId, int jobId) async {
    String url = 'http://10.0.2.2:8088/api/v1/application/$applicantId/$jobId';
    var respon = await http.get(Uri.parse(url));
    var utf8Body = utf8.decode(respon.bodyBytes); //có dạng json utf8
    //giải mã thành mảng string
    var data =
        jsonDecode(utf8Body); //có dạng đối tượng Dart (như List, Map,...)
    Application dataObject =
        Application.fromJson(data); //chuyển thành đối tượng application;

    if (respon.statusCode == 200 || respon.statusCode == 201) {
      print(dataObject);
    }
    print("in repo: fetch interaction is running");
    return dataObject;
  }

  static Future<List<Application>> fetchAllApplication(int applicantId) async {
    print("in repo: fetch interaction is starting with id = $applicantId");
    String url = 'http://10.0.2.2:8088/api/v1/application/$applicantId';
    var respon = await http.get(Uri.parse(url));
    var utf8Body = utf8.decode(respon.bodyBytes); //có dạng json utf8
    //giải mã thành mảng string
    // print(utf8Body);
    List<dynamic> datas =
        jsonDecode(utf8Body); //có dạng đối tượng Dart (như List, Map,...)
    // print(" datas is $datas");
    List<Application> dataObject = datas
        .map((data) => Application.fromJson(data))
        .toList(); //chuyển thành đối tượng application;
    // print("_-------------------====");
    if (respon.statusCode == 200 || respon.statusCode == 201) {
      print(dataObject);
    } else {
      print(respon.body);
    }
    print("length all application is: ${dataObject.length}");

    return dataObject;
  }

//CHƯA DÙNG ĐẾN
  static Future<void> updateRead() async {
    ;
  }

  static Future<dynamic> toggleSave(
      int applicantId, int jobId, bool isSave) async {
    print("in repo: isSave in repo is $isSave");
    String url =
        'http://10.0.2.2:8088/api/v1/interaction/save/$applicantId/$jobId';
    var respon = await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/Json"},
      body: jsonEncode(
        {
          "is_save": isSave ? 1 : 0,
        },
      ),
    );
    if (respon.statusCode == 200 || respon.statusCode == 201) {
      print(respon.body);
      return true;
    }
    if (respon.statusCode == 500) {
      throw Exception("in repo:interaction not found");
    } else {
      print("lỗi ${respon.statusCode} - ${respon.body}");
      return false;
    }
  }
}
