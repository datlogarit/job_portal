import 'package:job_portal/models/applicant_model.dart';
import 'package:job_portal/models/job_model.dart';

class Application {
  String? createdAt;
  String? updatedAt;
  int? id;
  Applicant? applicantId;
  Job? jobId;
  String? statusApply;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? cvUrl;
  String? message;

  Application(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.applicantId,
      this.jobId,
      this.statusApply,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.cvUrl,
      this.message});

  Application.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    applicantId = json['applicantId'] != null
        ? new Applicant.fromJson(json['applicantId'])
        : null;
    jobId = json['jobId'] != null ? new Job.fromJson(json['jobId']) : null;
    statusApply = json['statusApply'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    cvUrl = json['cvUrl'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    if (this.applicantId != null) {
      data['applicantId'] = this.applicantId!.toJson();
    }
    if (this.jobId != null) {
      data['jobId'] = this.jobId!.toJson();
    }
    data['statusApply'] = this.statusApply;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['cvUrl'] = this.cvUrl;
    data['message'] = this.message;
    return data;
  }
}
