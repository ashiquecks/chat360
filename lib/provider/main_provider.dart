import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
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

  Map<String, dynamic> categoryList = {};

  List<String> categoryValue = [];

  final categoryBox = Hive.box('selectedCategories');

  // Controllers for input form filed
  TextEditingController chatLink = TextEditingController();

  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController organizationController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();

  ParseFile? userProfilePick; // As File Image

  String? profileImage; //AS Network Image

  String? userID;
  String? userName;
  String? userPhone;
  String? organizationName;
  String? gstNumber;
  String? buildingNumber;
  String? accountType;
  bool? verified;
  bool? isCreator;



  List<int> failedList = [];

  XFile? pickedFile;
  XFile? image;
  XFile? emptyImage;

  bool createReply = false;

  setCreateReply() {
    createReply = !createReply;
    notifyListeners();
  }

  // get image from phone gallery..
  Future<void> getImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedFile = image;
    }
    notifyListeners();
  }

  clearImage() {
    pickedFile = null;
    notifyListeners();
  }

  increaseFailedCount(int count) {
    failedList.add(count);
    notifyListeners();
  }


  setSharePreferencesData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    userID = preferences.getString("userID");
    userName = preferences.getString("userName");
    userPhone = preferences.getString("userPhone");
    organizationName = preferences.getString("organizationName");
    gstNumber = preferences.getString("gstNumber");
    buildingNumber = preferences.getString("buildingNumber");
    verified = preferences.getBool("isVerified");
    accountType = preferences.getString("accountType");
    profileImage = preferences.getString("profilePick");
    isCreator = preferences.getBool("isCreator");
    notifyListeners();
  }

  // setCredentials(NetworkResponse<AccountCredentialModal> response) {
  //   userName = response.data!.userName;
  //   userPhone = response.data!.phoneNumber;
  //   organizationName = response.data!.phoneNumber;
  //   gstNumber = response.data!.phoneNumber;
  //   buildingNumber = response.data!.phoneNumber;
  //   isCreator = response.data!.creator;
  //   categoryList = response.data!.categoryTypes;
  //   notifyListeners();
  // }

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

  clearSharePreferenceCredential() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  void getCategoryList() {
    if (categoryBox.isNotEmpty) {
      final boxItem = categoryBox.getAt(0);
      final jsonData = jsonDecode(jsonEncode(boxItem));
      categoryList = jsonData['category'];
      categoryList.forEach((key, value) {
        categoryValue.add(value);
      });
      notifyListeners();
    }
  }

  Future<void> setCategoryList({required Map<String, dynamic> categoryTypes}) async {
    categoryValue.clear();
    await categoryBox.add({'category': categoryTypes});
    getCategoryList();
  }
}
