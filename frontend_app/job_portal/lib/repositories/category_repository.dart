import 'dart:convert'; //cung cấp các method để mã hóa và giải mã json

import 'package:http/http.dart' as http; //thư viện để gửi request http
import 'package:job_portal/models/category_model.dart'; //đại diện cho đối tượng category

class CategoryRepository {
  Future<List<Category>> getCategory() async {
    const url = "http://10.0.2.2:8088/api/v1/category";
    final respon = await http.get(Uri.parse(url));
    var utf8Body = utf8.decode(respon
        .bodyBytes); //get không thể nhận trực tiếp url mà phải ptich thành URI
    List data = //--> data bây h là 1 đối tượng dart
        jsonDecode(utf8Body); //hàm decode giải mã json thành 1 đối tượng dart
    List<Category> categories = data
        .map((e) =>
            Category.fromJson(e)) //sẽ trả về 1 interable chứ chưa phải list
        .toList(); //muốn nhận về list thì phải thêm toList
    print("in repo: fetching category");
    return categories;
  }
}
