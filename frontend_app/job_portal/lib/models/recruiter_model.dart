import 'package:job_portal/models/company_model.dart';
import 'package:job_portal/models/user_model.dart';

class Recruiter {
  int? id;
  User? userId;
  Company? companyId;
  int? isVerify;
  int? numberOfPost;
  String? position;

  Recruiter(
      {this.id,
      this.userId,
      this.companyId,
      this.isVerify,
      this.numberOfPost,
      this.position});

  Recruiter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'] != null ? new User.fromJson(json['userId']) : null;
    companyId = json['companyId'] != null
        ? new Company.fromJson(json['companyId'])
        : null;
    isVerify = json['isVerify'];
    numberOfPost = json['numberOfPost'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    if (this.companyId != null) {
      data['companyId'] = this.companyId!.toJson();
    }
    data['isVerify'] = this.isVerify;
    data['numberOfPost'] = this.numberOfPost;
    data['position'] = this.position;
    return data;
  }
}
