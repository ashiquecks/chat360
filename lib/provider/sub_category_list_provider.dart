import 'package:chat360/modal/category_model.dart';
import 'package:flutter/material.dart';

class SubCategoryListProvider extends ChangeNotifier {
  bool checkedValue = false;
  bool _isProcessing = true;
  List<CategoryModel> _categoryList = [];
  List<CategoryModel> subCategoryList = [];

  Map<String, dynamic> drawerList = {};

  bool get isProcessing => _isProcessing;
  List<CategoryModel> get categoryList => _categoryList;

  void setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  void setDrawerCategory(List<CategoryModel> list) {
    for (var data in list) {
      createSubCategoryList(data.objectId);
    }
  }

  void setCategory(List<CategoryModel> list) {
    _categoryList = list;
    notifyListeners();
  }

  void mergeCategoryList(List<CategoryModel> list) {
    _categoryList = list;
    notifyListeners();
  }

  bool createSubCategoryList(String objectId) {
    subCategoryList = _categoryList.where((element) => element.categoryId == objectId).toList();
    drawerList.putIfAbsent(objectId, () => subCategoryList);
    notifyListeners();
    return subCategoryList.isNotEmpty;
  }
}