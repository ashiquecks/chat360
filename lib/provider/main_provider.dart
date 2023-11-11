import 'package:chat360/service/shared_preference.dart/shared_preference.dart';
import 'package:flutter/material.dart';
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
  bool verified = false;

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
}
