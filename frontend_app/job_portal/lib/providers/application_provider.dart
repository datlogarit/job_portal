import 'package:flutter/material.dart';
import 'package:job_portal/models/application_model.dart';
import 'package:job_portal/repositories/application_repository.dart';
import 'package:job_portal/repositories/interaction_repository.dart';

class ApplicationProvider extends ChangeNotifier {
  Application _application = Application(); // "_" đây là ký hiệu của private
  List<Application> _allApplication = [];
  bool _isLoadingApplication = true;
  Application get application => _application;
  List<Application> get allApplication =>
      _allApplication; //getter để lấy giá trị của biến private
  bool get isLoading => _isLoadingApplication;

  Future<void> fetchApplication(int applicantId, int jobId) async {
    try {
      _application =
          await ApplicationRepository.fetchApplication(applicantId, jobId);
    } catch (e) {
      throw Exception("in provider: Application not found");
    }
    _isLoadingApplication = false;
    notifyListeners();
  }

  Future<void> fetchAllApplication(int applicantId) async {
    try {
      _allApplication =
          await ApplicationRepository.fetchAllApplication(applicantId);
    } catch (e) {
      throw Exception("in provider: Application not found");
    }
    _isLoadingApplication = false;
    notifyListeners(); //🔥 Thông báo rằng _isLoadingInteraction và_jobs đã thay đổi lần nữa
  }

  // Future<void> createApplication(int applicanId, int jobId) async {
  //   try {
  //     await ApplicationRepository.createApplication(applicanId, jobId);
  //   } catch (e) {
  //     throw Exception("Tạo mới Interaction thất bại");
  //   }
  // }
}
