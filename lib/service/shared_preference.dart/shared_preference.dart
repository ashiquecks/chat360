import 'package:shared_preferences/shared_preferences.dart';

setUserData({
  required String userID,
  required String userName,
  required String userPhone,
  required String profilePick,
  required String organizationName,
  required String organizationGst,
  required String organizationBuildingNumber,
  required String accountType,
}) async {
  SharedPreferences userPreferences = await SharedPreferences.getInstance();
  userPreferences.setString('userID', userID);
  userPreferences.setString('userName', userName);
  userPreferences.setString('userPhone', userPhone);
  userPreferences.setString('profilePick', profilePick);
  userPreferences.setString('organizationName', organizationName);
  userPreferences.setString('gstNumber', organizationGst);
  userPreferences.setString('buildingNumber', organizationBuildingNumber);
  userPreferences.setString('accountType', accountType);
}
