class Company {
  int? id;
  String? name;
  String? location;
  String? introduction;
  String? urlAvt;
  Null? hotline;

  Company(
      {this.id,
      this.name,
      this.location,
      this.introduction,
      this.urlAvt,
      this.hotline});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    introduction = json['introduction'];
    urlAvt = json['url_avt'];
    hotline = json['hotline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['introduction'] = this.introduction;
    data['url_avt'] = this.urlAvt;
    data['hotline'] = this.hotline;
    return data;
  }
}
