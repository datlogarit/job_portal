import 'package:flutter/material.dart';
import 'package:job_portal/models/category_model.dart';
import 'package:job_portal/repositories/category_repository.dart';

class CategoryProvider extends ChangeNotifier {
  //lớp ChangeNotifier cho phép thông báo tới client khi có sự thay đổi dữ liệu, giúp UI cập nhật tự động
  bool _isLoading = true;
  String _idCategoryChoose = "Tất cả";
  int _selectedItem = 0;
  int get selectedItem => _selectedItem;
  List<Category> _listCategory = [];
  bool get isLoading => _isLoading;
  String get idCategoryChoose => _idCategoryChoose;
  void setNameCategoryChoose(String categoryChooseName) {
    _idCategoryChoose = categoryChooseName;
  }

  List<Category> get listCategory => _listCategory;
  Future<void> getListCategory() async {
    _listCategory = await CategoryRepository().getCategory();
    _isLoading = false;
    notifyListeners(); //thông báo tất cả các widget đang lắng nghe provider này là data đã thay đổi,
    //UI sẽ autoUpdate mà không cần setState
  }

  void setIdCateoryChoose(String nameCategory) {
    _idCategoryChoose = nameCategory;
    notifyListeners();
  }

  void setSelectedItem(int selectedItem) {
    _selectedItem = selectedItem;
    notifyListeners();
  }
}
