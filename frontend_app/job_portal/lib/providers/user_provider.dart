import 'package:flutter/material.dart';
import 'package:job_portal/models/user_model.dart';
import 'package:job_portal/repositories/user_reposotory.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(); //khởi tạo biến private
  bool _isLoading = true;
  User get user => _user; //tạo các hàm getter, setter để lấy giá trị private
  bool get isLoading => _isLoading;

  Future<void> getUser(String email, String password, String role) async {
    Map<String, dynamic> user =
        await UserReposotory.login(email, password, role);
    _user = User.fromJson(
        user); //chuyển từ user nhận được từ server (dạng Map về đối tượng User)
    _isLoading = false;
    notifyListeners(); //thông báo cho UI
  }
  //fetch dữ liệu và tiến hành lưu vào User model
}
