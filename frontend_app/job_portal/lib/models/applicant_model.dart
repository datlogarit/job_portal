import 'package:job_portal/models/user_model.dart';

class Applicant {
  int? id;
  User? userId;
  String? resume;
  String? gender;
  String? workingTime;
  String? profession;
  String? desiredPosition;
  String? desiredLocation;
  String? workExperience;

  Applicant(
      {this.id,
      this.userId,
      this.resume,
      this.gender,
      this.workingTime,
      this.profession,
      this.desiredPosition,
      this.desiredLocation,
      this.workExperience});

  Applicant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'] != null ? new User.fromJson(json['userId']) : null;
    resume = json['resume'];
    gender = json['gender'];
    workingTime = json['workingTime'];
    profession = json['profession'];
    desiredPosition = json['desiredPosition'];
    desiredLocation = json['desiredLocation'];
    workExperience = json['workExperience'];
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
    data['profession'] = this.profession;
    data['desiredPosition'] = this.desiredPosition;
    data['desiredLocation'] = this.desiredLocation;
    data['workExperience'] = this.workExperience;
    return data;
  }
}
