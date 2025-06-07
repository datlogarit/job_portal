import 'dart:convert';

import 'package:http/http.dart' as http;

class ReportRepository {
  static Future<bool> sendReport(
      int reportedJob, int reporter, String reason) async {
    final url = Uri.parse('http://10.0.2.2:8088/api/v1/report');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer YOUR_ACCESS_TOKEN' // Nếu có xác thực
      },
      body: jsonEncode({
        //mã hóa thành json
        'reported_job': reportedJob,
        'reporter': reporter,
        'reason': reason
      }),
    );
    print("in repo: sending report");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Gửi thành công: ${response.body}');
      return true;
    } else {
      print('Lỗi: ${response.statusCode} - ${response.body}');
      return false;
    }
  }
}
