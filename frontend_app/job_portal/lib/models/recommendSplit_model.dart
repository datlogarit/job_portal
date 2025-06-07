import 'package:job_portal/models/job_model.dart';

class RecommendSplitModel {
  int? numJobContentBased;
  List<Job>? jobListCb;
  int? numJobCollaborativeFiltering;
  List<Job>? jobsListCf;

  RecommendSplitModel(
      {this.numJobContentBased,
      this.jobListCb,
      this.numJobCollaborativeFiltering,
      this.jobsListCf});

  RecommendSplitModel.fromJson(Map<String, dynamic> json) {
    numJobContentBased = json['numJobContentBased'];
    if (json['jobListCb'] != null) {
      jobListCb = <Job>[];
      json['jobListCb'].forEach((v) {
        jobListCb!.add(new Job.fromJson(v));
      });
    }
    numJobCollaborativeFiltering = json['numJobCollaborativeFiltering'];
    if (json['jobsListCf'] != null) {
      jobsListCf = <Job>[];
      json['jobsListCf'].forEach((v) {
        jobsListCf!.add(new Job.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numJobContentBased'] = this.numJobContentBased;
    if (this.jobListCb != null) {
      data['jobListCb'] = this.jobListCb!.map((v) => v.toJson()).toList();
    }
    data['numJobCollaborativeFiltering'] = this.numJobCollaborativeFiltering;
    if (this.jobsListCf != null) {
      data['jobsListCf'] = this.jobsListCf!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
