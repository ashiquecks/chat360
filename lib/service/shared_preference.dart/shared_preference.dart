import 'package:shared_preferences/shared_preferences.dart';

setUserData(
    {required String userID,
    required String userName,
    required String userPhone}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences = await SharedPreferences.getInstance();
  preferences.setString('userID', userID);
  preferences.setString('userName', userID);
  preferences.setString('userPhone', userID);
}
