import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;
setUserData({
  required String userId,
  required String userPassword,
  required String userName,
  required String userPhone,
  required bool registerStatus,
}) async {
  preferences = await SharedPreferences.getInstance();
  preferences!.setString("userId", userId);
  preferences!.setString("userName", userName);
  preferences!.setString("userPhone", userPhone);
  preferences!.setString("userPassword", userPassword);
  preferences!.setBool("registeredUser", registerStatus);
}
