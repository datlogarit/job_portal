import 'package:flutter/material.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/repositories/job_repository.dart';

class JobProvider extends ChangeNotifier {
  List<Job> _jobs = [];
  List<Job> _jobsBySearch = []; // "_" đây là ký hiệu của private
  bool _isLoading = true;

  List<Job> get jobs => _jobs;
  List<Job> get jobsBySearch =>
      _jobsBySearch; //getter để lấy giá trị của biến private
  bool get isLoading => _isLoading;
  JobProvider() {
    getJobs();
  }
  Future<void> getJobs() async {
    try {
      _jobs = await JobRepository.fetchJobs();
    } catch (e) {
      print("ERROR: $e");
    }
    _isLoading = false;
    notifyListeners(); //🔥 Thông báo rằng _isLoading và_jobs đã thay đổi lần nữa
  }

  Future<void> searchJob(String keyword) async {
    _isLoading = true;
    notifyListeners();
    try {
      _jobsBySearch = await JobRepository.fetchJobs(searchKey: keyword);
    } catch (e) {
      print("ERROR: $e");
    }
    _isLoading = false;
    notifyListeners(); //🔥 Thông báo rằng _isLoading và_jobs đã thay đổi lần nữa
  }
}
//thực ra ở class này không có gì đặc biệt, nó chỉ hỗ trợ thông báo tới UI
// khi có sự thay đổi dữ liệu bằng notifyListeners;
