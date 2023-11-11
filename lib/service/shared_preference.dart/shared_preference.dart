import 'package:shared_preferences/shared_preferences.dart';

setUserData({
  required String userID,
  required String userName,
  required String userPhone,
  required String profilePick,
  required String organizationName,
  required String organizationGst,
  required String organizationBuildingNumber,
}) async {
  SharedPreferences userPreferences = await SharedPreferences.getInstance();
  userPreferences = await SharedPreferences.getInstance();
  userPreferences.setString('userID', userID);
  userPreferences.setString('userName', userName);
  userPreferences.setString('userPhone', userPhone);
  userPreferences.setString('profilePick', profilePick);
  userPreferences.setString('organizationName', organizationName);
  userPreferences.setString('gstNumber', organizationGst);
  userPreferences.setString('buildingNumber', organizationBuildingNumber);
}

// setOrganizationData({
//   required String userID,
//   required String userName,
//   required String userPhone,
//   required String profilePick,
//   required String organizationName,
//   required String organizationGst,
//   required String organizationBuildingNumber,
// }) async {
//   SharedPreferences organizationPreferences =
//       await SharedPreferences.getInstance();
//   organizationPreferences = await SharedPreferences.getInstance();
//   organizationPreferences.setString('userID', userID);
//   organizationPreferences.setString('userName', userName);
//   organizationPreferences.setString('userPhone', userPhone);
  
//   organizationPreferences.setString('profilePick', profilePick);
// }
