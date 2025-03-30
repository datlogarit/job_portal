import 'package:job_portal/models/noti_user_key.dart';
import 'package:job_portal/models/notification_model.dart';
import 'package:job_portal/models/user_model.dart';

class NotiUser {
  NotiUserKey? id;
  Notification? idNoti;
  User? idUser;
  int? isRead;

  NotiUser({this.id, this.idNoti, this.idUser, this.isRead});

  NotiUser.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? new NotiUserKey.fromJson(json['id']) : null;
    idNoti = json['idNoti'] != null
        ? new Notification.fromJson(json['idNoti'])
        : null;
    // idUser = json['idUser'] != null ? new User.fromJson(json['idUser']) : null;
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id!.toJson();
    }
    if (this.idNoti != null) {
      data['idNoti'] = this.idNoti!.toJson();
    }
    // if (this.idUser != null) {
    //   data['idUser'] = this.idUser!.toJson();
    // }
    data['isRead'] = this.isRead;
    return data;
  }
}
