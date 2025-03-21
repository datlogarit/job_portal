class User {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? dob;
  String? role;
  String? urlAvatar;
  int? isActive;

  User(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.name,
      this.email,
      this.password,
      this.phoneNumber,
      this.dob,
      this.role,
      this.urlAvatar,
      this.isActive});

  User.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    dob = json['dob'];
    role = json['role'];
    urlAvatar = json['urlAvatar'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['dob'] = this.dob;
    data['role'] = this.role;
    data['urlAvatar'] = this.urlAvatar;
    data['isActive'] = this.isActive;
    return data;
  }
}
