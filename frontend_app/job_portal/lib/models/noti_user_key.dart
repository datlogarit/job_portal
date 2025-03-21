class NotiUserKey {
  int? idNoti;
  int? idUser;

  NotiUserKey({this.idNoti, this.idUser});

  NotiUserKey.fromJson(Map<String, dynamic> json) {
    idNoti = json['idNoti'];
    idUser = json['idUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idNoti'] = this.idNoti;
    data['idUser'] = this.idUser;
    return data;
  }
}
