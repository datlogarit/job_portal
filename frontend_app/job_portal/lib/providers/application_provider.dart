import 'package:flutter/material.dart';
import 'package:job_portal/models/application_model.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/repositories/application_repository.dart';
import 'package:job_portal/repositories/job_repository.dart';

class ApplicationProvider extends ChangeNotifier {
  Application _application = Application(); // "_" đây là ký hiệu của private
  bool _isLoadingApplication = true;
  bool _isSave = false;
  Application get application =>
      _application; //getter để lấy giá trị của biến private
  bool get isLoading => _isLoadingApplication;
  bool get isSave => _isSave;

  Future<void> fetchApplication(int applicantId, int jobId) async {
    try {
      _application =
          await ApplicationRepository.fetchApplication(applicantId, jobId);
      if (_application.isSaved == 1) {
        _isSave = false;
        notifyListeners();
      }
    } catch (e) {
      throw Exception("in provider: application not found");
    }

    _isLoadingApplication = false;
    notifyListeners(); //🔥 Thông báo rằng _isLoadingApplication và_jobs đã thay đổi lần nữa
  }

  Future<void> toggleIsSave(int applicanId, int jobId, bool isSave) async {
    try {
      await ApplicationRepository.toggleSave(applicanId, jobId, isSave);
    } catch (e) {
      createApplication(applicanId, jobId);
    }
  }

  Future<void> createApplication(int applicanId, int jobId) async {
    try {
      await ApplicationRepository.createApplication(applicanId, jobId);
    } catch (e) {
      throw Exception("Tạo mới application thất bại");
    }
  }
}
