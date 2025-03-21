import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:job_portal/models/application_model.dart';
import 'package:http/http.dart' as http;

class ApplicationRepository {
  static Future<List<Application>> fetchApplication(int id) async {
    String url = 'http://10.0.2.2:8088/api/v1/application/$id';
    var respon = await http.get(Uri.parse(url));
    if (respon.statusCode == 200) {
      final String utf8Body =
          utf8.decode(respon.bodyBytes); //giải mã thành mảng string
      List<dynamic> data = jsonDecode(utf8Body);
      List<Application> dataObject =
          data.map((application) => Application.fromJson(application)).toList();
      return dataObject;
    } else {
      throw Exception("false load application");
    }
    // return
  }
}
