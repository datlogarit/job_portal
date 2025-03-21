import 'package:job_portal/models/applicant_model.dart';
import 'package:job_portal/models/job_model.dart';

class Report {
  String? createdAt;
  String? updatedAt;
  int? id;
  Job? reportedJob;
  Applicant? reporter;
  String? reason;
  int? isSolve;

  Report(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.reportedJob,
      this.reporter,
      this.reason,
      this.isSolve});

  Report.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    reportedJob = json['reportedJob'] != null
        ? new Job.fromJson(json['reportedJob'])
        : null;
    reporter = json['reporter'] != null
        ? new Applicant.fromJson(json['reporter'])
        : null;
    reason = json['reason'];
    isSolve = json['isSolve'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    if (this.reportedJob != null) {
      data['reportedJob'] = this.reportedJob!.toJson();
    }
    if (this.reporter != null) {
      data['reporter'] = this.reporter!.toJson();
    }
    data['reason'] = this.reason;
    data['isSolve'] = this.isSolve;
    return data;
  }
}
