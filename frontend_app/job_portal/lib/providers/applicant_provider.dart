import 'package:flutter/material.dart';
import 'package:job_portal/models/applicant_model.dart';
// import 'package:job_portal/models/user_model.dart';
import 'package:job_portal/repositories/applicant_repository.dart';

class ApplicantProvider extends ChangeNotifier {
  Applicant _applicant = Applicant(); //khởi tạo biến private
  bool _isLoading = true;
  Applicant get applicant =>
      _applicant; //tạo các hàm getter, setter để lấy giá trị private
  bool get isLoading => _isLoading;

  Future<void> getApplicant(String email, String password) async {
    Map<String, dynamic> applicant =
        await ApplicantRepository.login(email, password);
    _applicant = Applicant.fromJson(
        applicant); //chuyển từ user nhận được từ server (dạng Map về đối tượng User)
    _isLoading = false;
    notifyListeners(); //thông báo cho UI
  }

  // Future<void> getUserUpdate(int id) async {
  //   _applicant = await ApplicantRepository.getUserbyId(id);
  //   notifyListeners();
  // }

  Future<bool> updateUser(
      int id,
      String? name,
      String? password,
      String? phoneNumber,
      String? birthDay,
      String? gender,
      String? workingTime,
      int? field,
      String? desiredPosition,
      String? desiredLocation,
      String? workExperience) async {
    Map<String, dynamic> applicant =
        await ApplicantRepository.updateApplicantById(
            id,
            name,
            password,
            phoneNumber,
            birthDay,
            gender,
            workingTime,
            field,
            desiredPosition,
            desiredLocation,
            workExperience);
    _applicant = Applicant.fromJson(applicant);
    notifyListeners();
    return true;
  }
  //fetch dữ liệu và tiến hành lưu vào User model
}
