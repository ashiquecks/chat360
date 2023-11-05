import 'package:chat360/service/shared_preference.dart/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {
  // It's a categoryListCard Widget property
  String selectedCategory = "";

  // It's a ChatRoom Class property
  String messageId = "";

  //It's a Message Card widget property
  String textFieldValue = "";

  // Controllers for input form filed
  TextEditingController chatLink = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  String? userID;
  String? userName;
  String? userPhone;

  setUserCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userID = preferences.getString("userID") ?? "";
    userName = preferences.getString("userName") ?? "";
    userPhone = preferences.getString("userPhone") ?? "";
    notifyListeners();
  }

  // It's a ChatRoom Class Function
  setMessageId(String newMessageId) {
    messageId = newMessageId;
    notifyListeners();
  }

  // It's a categoryListCard Widget Function
  changeCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  //It's a Message Card widget Function
  setTextField(String text) {
    textFieldValue = text;
    notifyListeners();
  }
}
