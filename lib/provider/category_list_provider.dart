import 'package:chat360/modal/category_list_model.dart';
import 'package:flutter/material.dart';

class CategoryListProvider extends ChangeNotifier {
  bool checkedValue = false;
  bool _isProcessing = true;
  List<CategoryListModal> _messageList = [];
  bool get isProcessing => _isProcessing;

  Map<String, dynamic> categoryList = {};

  setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  setCategoryList(String category) {
    if (categoryList.containsKey(category)) {
      categoryList.remove(category);
    } else {
      categoryList.putIfAbsent(category, () => category);
    }

    notifyListeners();
  }

  List<CategoryListModal> get messageList => _messageList;

  setLabourList(List<CategoryListModal> list) {
    _messageList.addAll(list);
    notifyListeners();
  }

  mergeLabourList(List<CategoryListModal> list) {
    _messageList = list;
    notifyListeners();
  }

  CategoryListModal getPostByIndex(int index) => _messageList[index];
}
