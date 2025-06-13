import 'package:flutter/material.dart';
import 'package:job_portal/models/noti_user_model.dart';
import 'package:job_portal/repositories/notification_repository.dart';

class NotificationProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<NotiUser> _notiByUser = [];
  int _totalUnreadNoti = 0;
  bool get isLoading => _isLoading;
  List<NotiUser> get notiByUser => _notiByUser;
  int get totalUnreadNoti => _totalUnreadNoti;
  Future<void> getNotificationByUser(int userId) async {
    _notiByUser = await NotificationRepository.getNotificationByUser(userId);
    _isLoading = false;
    print("noti_provider is running");
    notifyListeners();
  }

  Future<void> countNotificationUnread(int userId) async {
    _totalUnreadNoti = await NotificationRepository.fetchTotalUnread(userId);
    print("totalUnread: $_totalUnreadNoti");
    // _isLoading = false;
    print("noti_provider is running");
    notifyListeners();
  }

  Future<void> updateReadNotification(int userId, int notiId) async {
    await NotificationRepository.updateIsRead(userId, notiId);
    await getNotificationByUser(userId);
  }
}
