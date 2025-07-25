import 'package:job_portal/models/category_model.dart';
import 'package:job_portal/models/user_model.dart';

class Applicant {
  int? id;
  User? userId;
  String? resume;
  String? gender;
  String? workingTime;
  Category? field;
  String? currentPosition;
  String? desiredPosition;
  String? desiredLocation;
  String? workExperience;
  String? skills;
  Applicant(
      {this.id,
      this.userId,
      this.resume,
      this.gender,
      this.workingTime,
      this.field,
      this.desiredPosition,
      this.desiredLocation,
      this.workExperience,
      this.skills});

  Applicant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'] != null ? new User.fromJson(json['userId']) : null;
    resume = json['resume'];
    gender = json['gender'];
    workingTime = json['workingTime'];
    field = json['field'] != null ? new Category.fromJson(json['field']) : null;
    desiredPosition = json['desiredPosition'];
    currentPosition = json['currentPosition'];
    desiredLocation = json['desiredLocation'];
    workExperience = json['workExperience'];
    skills = json['skills'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['resume'] = this.resume;
    data['gender'] = this.gender;
    data['workingTime'] = this.workingTime;
    if (this.field != null) {
      data['field'] = this.field!.toJson();
    }
    data['desiredPosition'] = this.desiredPosition;
    data['currentPosition'] = this.currentPosition;
    data['desiredLocation'] = this.desiredLocation;
    data['workExperience'] = this.workExperience;
    data['skills'] = this.skills;
    return data;
  }
}
