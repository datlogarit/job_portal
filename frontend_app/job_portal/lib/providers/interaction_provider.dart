import 'package:flutter/material.dart';
import 'package:job_portal/models/interaction_model.dart';
import 'package:job_portal/repositories/interaction_repository.dart';

class InteractionProvider extends ChangeNotifier {
  Interaction _interaction = Interaction();
  List<Interaction> _allInteraction = []; // "_" đây là ký hiệu của private
  bool _isLoadingInteraction = true;
  Interaction get interaction =>
      _interaction; //getter để lấy giá trị của biến private
  List<Interaction> get allIteraction => _allInteraction;
  bool get isLoading => _isLoadingInteraction;
  Future<void> fetchInteraction(int applicantId, int jobId) async {
    try {
      _interaction =
          await InteractionRepository.fetchInteraction(applicantId, jobId);
    } catch (e) {
      throw Exception("in provider: Interaction not found");
    }
    _isLoadingInteraction = false;
    notifyListeners(); //🔥 Thông báo rằng _isLoadingInteraction và_jobs đã thay đổi lần nữa
  }

  Future<void> fetchAllInteraction(int applicantId) async {
    try {
      _allInteraction =
          await InteractionRepository.fetchAllInteraction(applicantId);
    } catch (e) {
      throw Exception("in provider: Interaction not found");
    }
    _isLoadingInteraction = false;
    notifyListeners(); //🔥 Thông báo rằng _isLoadingInteraction và_jobs đã thay đổi lần nữa
  }

  Future<void> toggleIsSave(int applicanId, int jobId, bool isSave) async {
    try {
      await InteractionRepository.toggleSave(applicanId, jobId, isSave);
    } catch (e) {
      createInteraction(applicanId, jobId);
    }
  }

  Future<void> createInteraction(int applicanId, int jobId) async {
    try {
      await InteractionRepository.createInteraction(applicanId, jobId);
    } catch (e) {
      throw Exception("Tạo mới Interaction thất bại");
    }
  }
}
