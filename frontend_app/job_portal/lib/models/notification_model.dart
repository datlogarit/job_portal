import 'package:job_portal/models/application_model.dart';
import 'package:job_portal/models/job_model.dart';

class Notification {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? title;
  String? content;
  Job? jobRelated;
  Application? applicationId;

  Notification(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.title,
      this.content,
      this.jobRelated,
      this.applicationId});

  Notification.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    title = json['title'];
    content = json['content'];
    jobRelated = json['jobRelated'] != null
        ? new Job.fromJson(json['jobRelated'])
        : null;
    applicationId = json['applicationId'] != null
        ? new Application.fromJson(json['applicationId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    if (this.jobRelated != null) {
      data['jobRelated'] = this.jobRelated!.toJson();
    }
    if (this.applicationId != null) {
      data['applicationId'] = this.applicationId!.toJson();
    }
    return data;
  }
}
