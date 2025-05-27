import 'package:job_portal/models/applicant_model.dart';
import 'package:job_portal/models/job_model.dart';

class MergedInteraction {
  int? id;
  Applicant? applicantId;
  Job? jobId;
  String? statusApply;
  int? isSave;
  int? isRead;

  MergedInteraction(
      {this.id,
      this.applicantId,
      this.jobId,
      this.statusApply,
      this.isSave,
      this.isRead});

  MergedInteraction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicantId = json['applicantId'] != null
        ? new Applicant.fromJson(json['applicantId'])
        : null;
    jobId = json['jobId'] != null ? new Job.fromJson(json['jobId']) : null;
    statusApply = json['statusApply'];
    isSave = json['isSave'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.applicantId != null) {
      data['applicantId'] = this.applicantId!.toJson();
    }
    if (this.jobId != null) {
      data['jobId'] = this.jobId!.toJson();
    }
    data['statusApply'] = this.statusApply;
    data['isSave'] = this.isSave;
    data['isRead'] = this.isRead;
    return data;
  }
}
