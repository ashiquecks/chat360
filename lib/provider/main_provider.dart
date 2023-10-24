import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  String selectedCategory = "";

  String textFieldValue = "";

  String? userID;

  getUsrId({required String objectId}) {
    userID = objectId;
    notifyListeners();
  }

  changeCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  setTextField(String text) {
    textFieldValue = text;
    notifyListeners();
  }

  // User Creation

  TextEditingController userPhone = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  String? phoneNumber;

  setUserPhone(String setUserPhone) {
    phoneNumber = setUserPhone;
    notifyListeners();
  }

  setUserPassword(TextEditingController setUserPassword) {
    userPhone = setUserPassword;
    notifyListeners();
  }
}
