import 'package:flutter/material.dart';
import 'package:job_portal/models/application_model.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/repositories/application_repository.dart';
import 'package:job_portal/repositories/job_repository.dart';

class ApplicationProvider extends ChangeNotifier {
  List<Application> _applications = []; // "_" đây là ký hiệu của private
  bool _isLoading = false;

  List<Application> get application =>
      _applications; //getter để lấy giá trị của biến private
  bool get isLoading => _isLoading;
  Future<void> fetchApplication(int id) async {
    _isLoading =
        true; //cập nhật trạng thái để thể hiện ứng dụng đang tải dữ liệu
    notifyListeners(); //🔥 Thông báo rằng _isLoading đã thay đổi
    try {
      _applications = await ApplicationRepository.fetchApplication(id);
    } catch (e) {
      print("ERROR: $e");
    }
    _isLoading = false;
    notifyListeners(); //🔥 Thông báo rằng _isLoading và_jobs đã thay đổi lần nữa
  }
}
