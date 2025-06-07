import 'package:flutter/material.dart';
import 'package:job_portal/models/job_model.dart';
import 'package:job_portal/models/recommendSplit_model.dart';
import 'package:job_portal/repositories/job_repository.dart';

class JobProvider extends ChangeNotifier {
  List<Job> _jobs = [];
  List<Job> _jobsBySearch = []; // "_" đây là ký hiệu của private
  List<Job> _recommendedJobs = [];
  RecommendSplitModel _recommendedJobsSplit = RecommendSplitModel();
  List<Job> _sameJobs = [];
  bool _isLoading = true;
  bool _isLoadingRcmJob = true;

  List<Job> get jobs => _jobs;
  List<Job> get jobsBySearch =>
      _jobsBySearch; //getter để lấy giá trị của biến private
  List<Job> get recommendedJobs => _recommendedJobs;
  RecommendSplitModel get recommendedJobsSplit => _recommendedJobsSplit;
  List<Job> get sameJobs => _sameJobs;
  bool get isLoading => _isLoading;
  bool get isLoadingRcmJob => _isLoadingRcmJob;
  JobProvider() {
    getJobs();
    // getRecommendedJobs(1142, "frontend developer", 13, "Hà Nội");
  }
  Future<void> getJobs() async {
    try {
      _jobs = await JobRepository.fetchJobs();
    } catch (e) {
      print("ERROR: $e");
    }
    _isLoading = false;
    notifyListeners(); // Thông báo _isLoading và_jobs đã thay đổi.
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

  //lấy danh sách các việc làm được đề xuất cho người dùng
  Future<void> getRecommendedJobs(
      int userId, String title, int categoryId, String location) async {
    _isLoadingRcmJob = true;
    // notifyListeners();
    try {
      _recommendedJobs = await JobRepository.fetchRecommendedJobs(
          userId: userId,
          title: title,
          categoryId: categoryId,
          location: location);
    } catch (e) {
      print("ERROR: $e");
    }
    _isLoadingRcmJob = false;
    notifyListeners(); //Thông báo rằng _isLoading và_jobs đã thay đổi lần nữa
  }

  Future<void> getRecommendedJobsSplit(
      int userId, String title, int categoryId, String location) async {
    _isLoading = true;
    // notifyListeners();
    try {
      _recommendedJobsSplit = await JobRepository.fetchRecommendedJobsSplit(
          userId: userId,
          title: title,
          categoryId: categoryId,
          location: location);
    } catch (e) {
      print("ERROR: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getSameJobs(int jobId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _sameJobs = await JobRepository.fetchSameJob(jobId: jobId);
    } catch (e) {
      print("ERROR: $e");
    }
    _isLoading = false;
    notifyListeners(); //Thông báo rằng _isLoading và_jobs đã thay đổi lần nữa
  }
}
