import 'package:flutter/material.dart';
import 'package:job_portal/models/merged_interaction.dart';
import 'package:job_portal/repositories/merged_interaction.dart';

class MergedInteractionProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<MergedInteraction> _allInteraction = [];
  List<MergedInteraction> get allInteraction => _allInteraction;
  bool get isLoading => _isLoading;
  Future<void> getAllInteraction(int applicantId) async {
    try {
      _allInteraction =
          await MergedInteractionRepository.fetAllInteraction(applicantId);
      print(_allInteraction[0]);
    } catch (e) {
      print("ERROR: $e");
    }
    _isLoading = false;
    notifyListeners(); // Thông báo _isLoading và_jobs đã thay đổi.
  }
}
