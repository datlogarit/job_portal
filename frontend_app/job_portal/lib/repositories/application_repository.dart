import 'dart:convert';
import 'package:job_portal/models/application_model.dart';
import 'package:http/http.dart' as http;

class ApplicationRepository {
  static Future<dynamic> createApplication(int applicantId, int jobId) async {
    //chuyển đổi trạng thái isSave mỗi khi nhấn
    String url = 'http://10.0.2.2:8088/api/v1/application';
    var respon = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "applicant_id": applicantId,
          "job_id": jobId,
          "status_apply": "not yet",
          "is_save": 1,
          "is_read": 0,
        },
      ),
    );
    if (respon.statusCode == 200 || respon.statusCode == 201) {
      print(respon.body);
      return true;
    } else {
      print("lỗi ${respon.statusCode} - ${respon.body}");
      return false;
    }
  }

  static Future<Application> fetchApplication(
      int applicantId, int jobId) async {
    String url =
        'http://10.0.2.2:8088/api/v1/application/info?applicantId=$applicantId&jobId=$jobId';
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
    return dataObject;
  }

  static Future<dynamic> toggleSave(
      int applicantId, int jobId, bool isSave) async {
    print("isSave in repo is $isSave");
    //chuyển đổi trạng thái isSave mỗi khi nhấn
    String url =
        'http://10.0.2.2:8088/api/v1/application/save/$applicantId/$jobId';
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
      throw Exception("in repo:application not found");
    } else {
      print("lỗi ${respon.statusCode} - ${respon.body}");
      return false;
    }
  }

  static Future<void> updateRead() async {
    ;
  }
}
