import 'package:job_portal/models/category_model.dart';
import 'package:job_portal/models/recruiter_model.dart';

class Job {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? title;
  int? minSalary;
  int? maxSalary;
  String? experience;
  String? workingTime;
  int? numberRecruitment;
  String? gender;
  String? position;
  String? expDate;
  String? requirement;
  String? description;
  String? benefit;
  String? workLocation;
  Recruiter? postedBy;
  Category? categoryId;
  String? status;
  int? isEdit;
  int? isLock;
  int? isActive;

  Job(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.title,
      this.minSalary,
      this.maxSalary,
      this.experience,
      this.workingTime,
      this.numberRecruitment,
      this.gender,
      this.position,
      this.expDate,
      this.requirement,
      this.description,
      this.benefit,
      this.workLocation,
      this.postedBy,
      this.categoryId,
      this.status,
      this.isEdit,
      this.isLock,
      this.isActive});

  Job.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    title = json['title'];
    minSalary = json['minSalary'];
    maxSalary = json['maxSalary'];
    experience = json['experience'];
    workingTime = json['workingTime'];
    numberRecruitment = json['numberRecruitment'];
    gender = json['gender'];
    position = json['position'];
    expDate = json['expDate'];
    requirement = json['requirement'];
    description = json['description'];
    benefit = json['benefit'];
    workLocation = json['workLocation'];
    postedBy = json['postedBy'] != null
        ? new Recruiter.fromJson(json['postedBy'])
        : null;
    categoryId = json['categoryId'] != null
        ? new Category.fromJson(json['categoryId'])
        : null;
    status = json['status'];
    isEdit = json['isEdit'];
    isLock = json['isLock'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['title'] = this.title;
    data['minSalary'] = this.minSalary;
    data['maxSalary'] = this.maxSalary;
    data['experience'] = this.experience;
    data['workingTime'] = this.workingTime;
    data['numberRecruitment'] = this.numberRecruitment;
    data['gender'] = this.gender;
    data['position'] = this.position;
    data['expDate'] = this.expDate;
    data['requirement'] = this.requirement;
    data['description'] = this.description;
    data['benefit'] = this.benefit;
    data['workLocation'] = this.workLocation;
    if (this.postedBy != null) {
      data['postedBy'] = this.postedBy!.toJson();
    }
    if (this.categoryId != null) {
      data['categoryId'] = this.categoryId!.toJson();
    }
    data['status'] = this.status;
    data['isEdit'] = this.isEdit;
    data['isLock'] = this.isLock;
    data['isActive'] = this.isActive;
    return data;
  }
}
