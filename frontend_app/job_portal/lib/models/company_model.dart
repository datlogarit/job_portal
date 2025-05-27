class Company {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? taxCode;
  String? website;
  String? scale;
  String? email;
  String? name;
  String? location;
  String? introduction;
  String? urlAvt;
  String? hotline;

  Company(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.taxCode,
      this.website,
      this.scale,
      this.email,
      this.name,
      this.location,
      this.introduction,
      this.urlAvt,
      this.hotline});

  Company.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    taxCode = json['taxCode'];
    website = json['website'];
    scale = json['scale'];
    email = json['email'];
    name = json['name'];
    location = json['location'];
    introduction = json['introduction'];
    urlAvt = json['url_avt'];
    hotline = json['hotline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['taxCode'] = this.taxCode;
    data['website'] = this.website;
    data['scale'] = this.scale;
    data['email'] = this.email;
    data['name'] = this.name;
    data['location'] = this.location;
    data['introduction'] = this.introduction;
    data['url_avt'] = this.urlAvt;
    data['hotline'] = this.hotline;
    return data;
  }
}
