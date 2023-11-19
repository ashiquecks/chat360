import 'package:chat360/modal/account_credential_modal.dart';
import 'package:chat360/service/server_response/server_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

setSharedPreferences(NetworkResponse<AccountCredentialModal> response) async {
  SharedPreferences userPreferences = await SharedPreferences.getInstance();
  userPreferences.setString('userID', response.data!.objectId);
  userPreferences.setString('userName', response.data!.userName);
  userPreferences.setString('userPhone', response.data!.phoneNumber);
  userPreferences.setString('profilePick', response.data!.profilePick.url);
  userPreferences.setString('organizationName', response.data!.organizationName);
  userPreferences.setString('gstNumber', response.data!.gstNumber);
  userPreferences.setString('buildingNumber', response.data!.buildingNumber);
  userPreferences.setString('accountType', response.data!.accountType);
  userPreferences.setBool("isCreator", response.data!.creator);
  userPreferences.setBool("isVerified", response.data!.verified);
}
