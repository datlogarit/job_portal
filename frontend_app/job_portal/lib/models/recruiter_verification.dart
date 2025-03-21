import 'package:job_portal/models/recruiter_model.dart';

class RecruiterVerification {
  String? createdAt;
  String? updatedAt;
  int? id;
  Recruiter? recruiterId;
  Null? authorizationLetterUrl;
  Null? businessLicenseUrl;
  int? status;
  String? rejectReason;

  RecruiterVerification(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.recruiterId,
      this.authorizationLetterUrl,
      this.businessLicenseUrl,
      this.status,
      this.rejectReason});

  RecruiterVerification.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    recruiterId = json['recruiterId'] != null
        ? new Recruiter.fromJson(json['recruiterId'])
        : null;
    authorizationLetterUrl = json['authorizationLetterUrl'];
    businessLicenseUrl = json['businessLicenseUrl'];
    status = json['status'];
    rejectReason = json['rejectReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    if (this.recruiterId != null) {
      data['recruiterId'] = this.recruiterId!.toJson();
    }
    data['authorizationLetterUrl'] = this.authorizationLetterUrl;
    data['businessLicenseUrl'] = this.businessLicenseUrl;
    data['status'] = this.status;
    data['rejectReason'] = this.rejectReason;
    return data;
  }
}
