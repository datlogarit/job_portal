import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_portal/models/job_model.dart';

class JobRepository {
  static Future<List<Job>> fetchRecommendedJobs(
      {int? userId, String? title, int? categoryId, String? location}) async {
    String url;
    url = "http://10.0.2.2:8088/api/v1/job/recommendation";

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user_id': 1142,
        'title': "frontend developer",
        'category_id': 13,
        'work_location': "Hà Nội",
        'total_jobs': 15,
      }),
    );
    if (response.statusCode == 200) {
      final String utf8Body = utf8.decode(response.bodyBytes);
      List<dynamic> data = jsonDecode(utf8Body);
      List<Job> allJob = data.map((job) => Job.fromJson(job)).toList();
      return allJob
          .where((job) => DateTime.parse(job.expDate!).isAfter(DateTime
                  .now()) // Kiểm tra có lớn hơn thời gian hiện tại không
              ) //trả về danh sách mà có ngày hết hạn sau thời điểm hiện tại
          .toList();
    } else {
      throw Exception('Failed to load recommended jobs');
    }
  }

  static Future<List<Job>> fetchSameJob({int? jobId}) async {
    String url;
    url = "http://10.0.2.2:8088/api/v1/job/sameJob/${jobId}";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final String utf8Body = utf8.decode(response.bodyBytes);
      List<dynamic> data = jsonDecode(utf8Body);
      List<Job> allJob = data.map((job) => Job.fromJson(job)).toList();
      return allJob
          .where((job) => DateTime.parse(job.expDate!).isAfter(DateTime
                  .now()) // Kiểm tra có lớn hơn thời gian hiện tại không
              ) //trả về danh sách mà có ngày hết hạn sau thời điểm hiện tại
          .toList();
    } else {
      throw Exception('Failed to load same jobs');
    }
  }

  static Future<List<Job>> fetchJobs(
      {int page = 0, int limit = 10, String searchKey = ''}) async {
    String url;
    if (searchKey == '') {
      url = "http://10.0.2.2:8088/api/v1/job?page=0&limit=10";
    } else {
      url =
          'http://10.0.2.2:8088/api/v1/job?page=0&limit=10&search_keyword=$searchKey';
    }

    final response = await http.get(
      Uri.parse(url),
    );
    print("in repo: get jobjob in repo is running");
    if (response.statusCode == 200) {
      final String utf8Body = //mã -> rõ (từ json sang json tiếng việt)
          utf8.decode(response.bodyBytes); //giải mã mảng byte thành string
      List<dynamic> data = jsonDecode(
          utf8Body); //có thể chuyển về đối tượng trong dart (Map hoặc List - trong TH này là List)
      List<Job> allJob = data.map((job) => Job.fromJson(job)).toList();
      print("length of job: ${allJob.length}");
      return allJob
          .where((job) => DateTime.parse(job.expDate!).isAfter(DateTime
                  .now()) // Kiểm tra có lớn hơn thời gian hiện tại không
              ) //trả về danh sách mà có ngày hết hạn sau thời điểm hiện tại
          .toList();
      // return data.map((job) => Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}
//fetch data => mã hóa json thành utf8, sau đó chuyển json này về dạng 
//đối tượng trong dart (bằng hàm jsondecode, chuyển từ json thành kiểu Map hoặc list), cuối cùng chuyển nó thành 
//model tương ứng bằng hàm fromJson