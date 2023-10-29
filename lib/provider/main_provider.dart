import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  String selectedCategory = "";

  String messageId = "";

  String textFieldValue = "";

  String? userId;

  TextEditingController chatLink = TextEditingController();

  setUserId(String userID) {
    userId = userID;
    notifyListeners();
  }

  setMessageId(String newMessageId) {
    messageId = newMessageId;
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
