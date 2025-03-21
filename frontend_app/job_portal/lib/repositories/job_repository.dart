import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_portal/models/job_model.dart';

class JobRepository {
  static Future<List<Job>> fetchJobs({int page = 0, int limit = 10}) async {
    // Future.delayed(Duration(seconds: 20));
    final String url = "http://10.0.2.2:8088/api/v1/job?page=40&limit=6";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final String utf8Body =
          utf8.decode(response.bodyBytes); //giải mã mảng byte thành string
      List<dynamic> data = jsonDecode(
          utf8Body); //có thể chuyển về đối tượng trong dart (Map hoặc List - trong TH này là List)
      return data.map((job) => Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}
