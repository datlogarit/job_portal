import 'package:flutter/material.dart';
import 'package:job_portal/models/user_model.dart';
import 'package:job_portal/repositories/user_reposotory.dart';

class JobProvider extends ChangeNotifier {
  User _user = User(); //khởi tạo biến private
  bool _isLoading = true;
  User get user => _user; //tạo các hàm getter, setter để lấy giá trị private
  bool get isLoading => _isLoading;
  void getUser(String email, String password, String role) {
    Map<String, dynamic> user = UserReposotory.login(email, password, role);
    _user = User.fromJson(user);
    notifyListeners();
  }
  //fetch dữ liệu và tiến hành lưu vào User model
}
