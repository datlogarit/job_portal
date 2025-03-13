class CategoryModel {
  int? id;
  String? name;

  CategoryModel({required this.id, required this.name});

  //chuyển dữ liệu từ json thành object (nhận từ server)
  //đồng thời đây cũng là hàm khởi tạo được đặt tên: named constructor
  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    //chuyển dữ liệu từ Object sang json
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
