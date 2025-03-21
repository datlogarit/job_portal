import 'dart:convert'; //cung cấp các method để mã hóa và giải mã json

import 'package:http/http.dart' as http; //thư viện để gửi request http
import 'package:job_portal/models/category_model.dart'; //đại diện cho đối tượng category

class CategoryRepository {
  //lấy data từ api và chuyển về đối tượng model

  //future là đại diện cho 1 đối tượng có trong tương lai
  Future<List<Category>> getCategory() async {
    const url = "http://10.0.2.2:8088/api/v1/category";
    final respon = await http.get(Uri.parse(
        url)); //get không thể nhận trực tiếp url mà phải ptich thành URI
    List data = //--> data bây h là 1 đối tượng dart
        jsonDecode(
            respon.body); //hàm decode giải mã json thành 1 đối tượng dart
    List<Category> categories = data
        .map((e) =>
            Category.fromJson(e)) //sẽ trả về 1 interable chứ chưa phải list
        .toList(); //muốn nhận về list thì phải thêm toList
    return categories;
  }
}
