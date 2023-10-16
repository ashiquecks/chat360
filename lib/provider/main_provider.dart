import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  String selectedCategory = "";

  String textFieldValue = "";

  changeCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  setTextField(String text) {
    textFieldValue = text;
    notifyListeners();
  }
}
