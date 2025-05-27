import 'dart:convert';
import 'package:job_portal/models/interaction_model.dart';
import 'package:http/http.dart' as http;

class InteractionRepository {
  static Future<dynamic> createInteraction(int applicantId, int jobId) async {
    //chuyển đổi trạng thái isSave mỗi khi nhấn
    String url = 'http://10.0.2.2:8088/api/v1/interaction';
    var respon = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "applicant_id": applicantId,
          "job_id": jobId,
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

  static Future<Interaction> fetchInteraction(
      int applicantId, int jobId) async {
    String url = 'http://10.0.2.2:8088/api/v1/interaction/$applicantId/$jobId';
    var respon = await http.get(Uri.parse(url));
    var utf8Body = utf8.decode(respon.bodyBytes); //có dạng json utf8
    //giải mã thành mảng string
    var data =
        jsonDecode(utf8Body); //có dạng đối tượng Dart (như List, Map,...)
    Interaction dataObject =
        Interaction.fromJson(data); //chuyển thành đối tượng application;

    if (respon.statusCode == 200 || respon.statusCode == 201) {
      print(dataObject);
    }
    return dataObject;
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

  static Future<List<Interaction>> fetchAllInteraction(int applicantId) async {
    try {
      String url = 'http://10.0.2.2:8088/api/v1/interaction/$applicantId';
      var respon = await http.get(Uri.parse(url));

      if (respon.statusCode == 200 || respon.statusCode == 201) {
        var utf8Body = utf8.decode(respon.bodyBytes);
        List<dynamic> datas = jsonDecode(utf8Body);
        List<Interaction> dataObject =
            datas.map((data) => Interaction.fromJson(data)).toList();

        print("length all interaction is: ${dataObject.length}");
        return dataObject;
      } else {
        print('Fetch interaction failed: ${respon.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception in fetchAllInteraction: $e');
      return [];
    }
  }

  Future<bool> updateRead(int applicantId, int jobId) async {
    //chuyển đổi trạng thái isRead mỗi khi nhấn
    String url = 'http://10.0.2.2:8088/api/v1/interaction/read';
    var respon = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "applicant_id": applicantId,
          "job_id": jobId,
          "is_save": 0, //chỉ mang tính tượng trưng, chứ không được lưu.
          "is_read": 1, //đánh dấu trạng thái đọc là 1
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
}
