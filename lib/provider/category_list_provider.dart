import 'package:chat360/modal/category_model.dart';
import 'package:flutter/material.dart';

class CategoryListProvider extends ChangeNotifier {

  bool _isProcessing = true;
  List<CategoryModel> _dataList = [];
  bool get isProcessing => _isProcessing;

  setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  List<CategoryModel> get categoryList => _dataList;

  setDataList(List<CategoryModel> list) {
    _dataList.addAll(list);
    notifyListeners();
  }

  mergeDataList(List<CategoryModel> list) {
    _dataList = list;
    notifyListeners();
  }

  CategoryModel getPostByIndex(int index) => _dataList[index];
}