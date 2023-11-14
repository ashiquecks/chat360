import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {
  // It's a categoryListCard Widget property
  String selectedCategory = "";

  // It's a ChatRoom Class property
  String messageId = "";

  //It's a Message Card widget property
  String textFieldValue = "";

  ParseFile? profilePick;

  // Controllers for input form filed
  TextEditingController chatLink = TextEditingController();

  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController organizationController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();

  String? userID;
  String? userName;
  String? userPhone;
  String? organizationName;
  String? gstNumber;
  String? buildingNumber;
  String? userProfilePick;
  String? accountType;
  bool verified = false;

  Map<String, dynamic> categoryList = {};

  setCategoryList(Map<String, dynamic> category) {
    categoryList = categoryList;
    notifyListeners();
  }

  setUserCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userID = preferences.getString("userID") ?? "";
    userName = preferences.getString("userName") ?? "";
    userPhone = preferences.getString("userPhone") ?? "";
    organizationName = preferences.getString("organizationName") ?? "";
    gstNumber = preferences.getString("gstNumber") ?? "";
    buildingNumber = preferences.getString("buildingNumber") ?? "";
    verified = preferences.getBool("verifiedOrganization") ?? false;
    userProfilePick = preferences.getString("profilePick") ?? "";
    accountType = preferences.getString("accountType") ?? "";
    notifyListeners();
  }

  setProfilePick(ParseFile profileImage) {
    profilePick = profileImage;
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

  clearCredential() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    userID = "";
    userName = "";
    userPhone = "";
    userProfilePick = "";
    notifyListeners();
  }

  // List<Map<String, dynamic>> categoryItems = [];

  Map<String, dynamic> categoryItems = {};

  final categoryBox = Hive.box('selectedCategories');

  void getCategory() {

    final boxItem = categoryBox.getAt(0);

    final jsonData = jsonDecode(jsonEncode(boxItem));

    categoryItems = jsonData['category'];

    notifyListeners();
  }

  Future<void> createCategoryList({required Map<String, dynamic> categoryTypes}) async {
    await categoryBox.add({'category': categoryTypes});
  }
}
