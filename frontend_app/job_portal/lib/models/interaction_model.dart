import 'package:job_portal/models/applicant_model.dart';
import 'package:job_portal/models/job_model.dart';

class Interaction {
  String? createdAt;
  String? updatedAt;
  int? id;
  Applicant? applicantId;
  Job? jobId;
  int? isSaved;
  int? isRead;

  Interaction(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.applicantId,
      this.jobId,
      this.isSaved,
      this.isRead});

  Interaction.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    applicantId = json['applicantId'] != null
        ? new Applicant.fromJson(json['applicantId'])
        : null;
    jobId = json['jobId'] != null ? new Job.fromJson(json['jobId']) : null;
    isSaved = json['isSaved'];
    isRead = json['isRead'];
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
    data['isSaved'] = this.isSaved;
    data['isRead'] = this.isRead;
    return data;
  }
}
