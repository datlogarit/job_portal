import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApplicantRepository {
  // final Map<String, dynamic> content;
  ApplicantRepository();
  static dynamic login(String email, String password) async {
    Uri url = Uri.parse("http://10.0.2.2:8088/api/v1/applicant/login");
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
    if (data.statusCode == 200 || data.statusCode == 201) {
      return dataObj;
    } else {
      throw Exception(dataObj["message"]);
    }
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
    if (data.statusCode == 200) {
      return true;
    } else {
      String utf8Body =
          utf8.decode(data.bodyBytes); //giải mã dữ liệu từ mảng byte thành UTF8
      String content = jsonDecode(utf8Body)['message']; //chuyển từ json về map
      throw Exception(content); //ném ra ngoại lệ và bắt ở UI
    }
  }

  // static Future<User> getUserbyId(int userId) async {
  //   String url = 'http://10.0.2.2:8088/api/v1/user/$userId';
  //   var data = await http.get(Uri.parse(url)); //json
  //   String dataUtf8 = utf8.decode(data.bodyBytes); //có dạng utf8
  //   Map<String, dynamic> objDart =
  //       jsonDecode(dataUtf8); //đưa nó về dạng đối tượng dart Map, List,...
  //   User user = User.fromJson(objDart);
  //   print("${user.name}");
  //   return user;
  // }
  static Future<void> changePassword(
      int userId, String oldPassword, String newPassword) async {
    String url =
        "http://10.0.2.2:8088/api/v1/user/password/${userId}?oldPassword=${oldPassword}&newPassword=${newPassword}";
    var response = await http.put(Uri.parse(url));
    if (response.statusCode != 200 && response.statusCode != 201) {
      String utf8Body = utf8
          .decode(response.bodyBytes); //giải mã dữ liệu từ mảng byte thành UTF8
      String content = jsonDecode(utf8Body)['message'];
      throw Exception(content);
    }
  }

  static dynamic updateApplicantById(
    int applicantId,
    String? name,
    String? password,
    String? phoneNumber,
    String? birthDay,

    // String? gender,
    // String? workingTime,
    int? field,
    String? desiredJob,
    String? desiredLocation,
    String? currentJob,
    String? workExperience,
    List<String>? skills,
  ) async {
    String url = 'http://10.0.2.2:8088/api/v1/applicant/$applicantId';
    var data = await http.put(Uri.parse(url),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "password": password,
          "phone_number": phoneNumber,
          "dob": birthDay,
          // "gender": gender,
          // "working_time": workingTime,
          "field": field,
          "desired_position": desiredJob,
          "desired_location": desiredLocation,
          "current_position": currentJob,
          "work_experience": workExperience,
          "skills": skills?.join(", ")
        })); //json
    if (data.statusCode == 200 || data.statusCode == 201) {
      var formatUtf8 = utf8.decode(data.bodyBytes); //
      Map<String, dynamic> dataObj = jsonDecode(formatUtf8);
      return dataObj;
    } else {
      //co data dang json
      var utf8Body = utf8.decode(data.bodyBytes);
      var objDart = jsonDecode(utf8Body);
      throw Exception(objDart['message']);
      // print(data.body);
    }
  }

  static Future updateAvt(int userId, File avtFile) async {
    String extension = avtFile.path.split('.').last.toLowerCase();
    String mimeType = extension == 'png' ? 'png' : 'jpeg';
    String url = "http://10.0.2.2:8088/api/v1/user/image/$userId";
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'file', // tên key bên backend
        avtFile.path,
        contentType: DioMediaType('image', mimeType),
      ),
    );
    var data = await request.send();

    if (data.statusCode == 200 || data.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Change avatar successfully",
          backgroundColor: Color.fromRGBO(67, 177, 183, 1),
          gravity: ToastGravity.CENTER,
          fontSize: 18);
    } else {
      Fluttertoast.showToast(
        msg: "Change avatar failed",
        backgroundColor: Colors.red,
        gravity: ToastGravity.CENTER,
        fontSize: 18,
      );
    }
  }
}
