import 'package:job_portal/models/company_model.dart';
import 'package:job_portal/models/recruiter_verification.dart';
import 'package:job_portal/models/user_model.dart';

class Recruiter {
  int? id;
  User? userId;
  Company? companyId;
  RecruiterVerification? verifyId;

  Recruiter({this.id, this.userId, this.companyId, this.verifyId});

  Recruiter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'] != null ? new User.fromJson(json['userId']) : null;
    companyId = json['companyId'] != null
        ? new Company.fromJson(json['companyId'])
        : null;
    verifyId = json['verifyId'] != null
        ? new RecruiterVerification.fromJson(json['verifyId'])
        : null;
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
    if (this.verifyId != null) {
      data['verifyId'] = this.verifyId!.toJson();
    }
    return data;
  }
}
