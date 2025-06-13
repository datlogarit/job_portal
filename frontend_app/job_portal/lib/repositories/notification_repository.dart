import 'dart:convert';

import 'package:job_portal/models/noti_user_model.dart';
import 'package:http/http.dart' as http;

class NotificationRepository {
  static Future<dynamic> getNotificationByUser(int userId) async {
    String url = "http://10.0.2.2:8088/api/v1/notiuser/$userId";
    var respon = await http.get(Uri.parse(url)); //dạng json

    var utf8Body = utf8.decode(respon.bodyBytes); //giải mã thành utf8
    List<dynamic> responObj = jsonDecode(utf8Body); // đưa về dạng list, Map,...
    if (respon.statusCode == 200 || respon.statusCode == 201) {
      print("in repo: notification fetching");
      print("leng is: ${responObj.length}");
      print(responObj);
      responObj
          .map((toElement) => NotiUser.fromJson(toElement))
          .toList(); //nhận được dưới dạng đối tượng

      return responObj
          .map((toElement) => NotiUser.fromJson(toElement))
          .toList();
    } else {
      print("${respon.statusCode} - ${respon.body}");
    }

    return null;
  }

  static Future<dynamic> fetchTotalUnread(int userId) async {
    String url = "http://10.0.2.2:8088/api/v1/notiuser/totalUnread/$userId";
    var respon = await http.get(Uri.parse(url)); //dạng json

    var utf8Body = utf8.decode(respon.bodyBytes); //giải mã thành utf8
    int responObj = jsonDecode(utf8Body); // đưa về dạng list, Map,...
    if (respon.statusCode == 200 || respon.statusCode == 201) {
      print("in repo: notification fetching");
      // print("leng is: ${responObj.length}");
      print(responObj);

      return responObj;
    } else {
      print("${respon.statusCode} - ${respon.body}");
    }

    return null;
  }

  static Future<dynamic> updateIsRead(int userId, int notiId) async {
    String url = "http://10.0.2.2:8088/api/v1/notiuser";
    var respon = await http.put(
      Uri.parse(url),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(
        {
          "id_noti": notiId,
          "id_user": userId,
          "is_read": 1,
        },
      ),
    ); //dạng json
    print("in repo: notification is updating isRead");

    if (respon.statusCode == 200 || respon.statusCode == 201) {
      print(respon.body);
    } else {
      print("${respon.statusCode} - ${respon.body}");
    }
  }
}
//done
