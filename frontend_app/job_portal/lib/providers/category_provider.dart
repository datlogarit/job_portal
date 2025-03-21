import 'package:flutter/material.dart';
import 'package:job_portal/models/category_model.dart';
import 'package:job_portal/repositories/category_repository.dart';

class CategoryProvider extends ChangeNotifier {
  //lớp ChangeNotifier cho phép thông báo tới client khi có sự thay đổi dữ liệu, giúp UI cập nhật tự động
  int? idCategoryChoose;
  List<Category> listCategory = [];
  Future<void> getListCategory() async {
    List<Category> allCategory = await CategoryRepository().getCategory();
    listCategory = allCategory;
    notifyListeners(); //thông báo tất cả các widget đang lắng nghe provider này là data đã thay đổi,
    //UI sẽ autoUpdate mà không cần setState
  }

  void setIdCateoryChoose(int id) {
    idCategoryChoose = id;
    notifyListeners();
  }
}
