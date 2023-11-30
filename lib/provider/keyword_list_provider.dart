import 'package:chat360/modal/keyword_list_model.dart';
import 'package:flutter/material.dart';

class KeywordListProvider extends ChangeNotifier {
  bool checkedValue = false;
  bool _isProcessing = true;
  List<KeywordsModal> _dataList = [];
  bool get isProcessing => _isProcessing;

  Map<String, dynamic> categoryList = {};

  List<String> categoryValue = [];

  setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  setCategoryList(String category, String label) {
    if (categoryList.containsKey(category)) {
      categoryList.remove(category);
    } else {
      categoryList.putIfAbsent(category, () => label);
    }
    notifyListeners();
  }

  createCategoryValueList() {
    categoryList.forEach((key, value) {
      if (categoryValue.contains(value)) {
        print("Already Created");
      } else {
        categoryValue.add(value);
      }
    });
  }

  List<KeywordsModal> get keywordList => _dataList;

  setDataList(List<KeywordsModal> list) {
    _dataList.addAll(list);
    notifyListeners();
  }

  mergeDataList(List<KeywordsModal> list) {
    _dataList = list;
    notifyListeners();
  }

  KeywordsModal getPostByIndex(int index) => _dataList[index];
}
