import 'package:flutter/material.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/repositories/job_repository.dart';

class JobProvider extends ChangeNotifier {
  List<Job> _jobs = []; // "_" đây là ký hiệu của private
  bool _isLoading = true;

  List<Job> get jobs => _jobs; //getter để lấy giá trị của biến private
  bool get isLoading => _isLoading;
  JobProvider() {
    //khởi tạo là tự động fetch job
    getJobs();
  }
  Future<void> getJobs() async {
    // _isLoading =
    //     true; //cập nhật trạng thái để thể hiện ứng dụng đang tải dữ liệu
    // notifyListeners(); //🔥 Thông báo rằng _isLoading đã thay đổi
    try {
      _jobs = await JobRepository.fetchJobs();
    } catch (e) {
      print("ERROR: $e");
    }
    _isLoading = false;
    notifyListeners(); //🔥 Thông báo rằng _isLoading và_jobs đã thay đổi lần nữa
  }
}
//thực ra ở class này không có gì đặc biệt, nó chỉ hỗ trợ thông báo tới UI
// khi có sự thay đổi dữ liệu bằng notifyListeners;
