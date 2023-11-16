import 'dart:convert';
import 'dart:io';
import 'package:chat360/modal/account_credential_modal.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<AccountCredentialModal>> getProfileDetailsUser({
  required String userID,
  required String tableName,
}) async {
  try {
    QueryBuilder<ParseObject> response = QueryBuilder<ParseObject>(
      ParseObject(tableName),
    );
    response.whereEqualTo('objectId', userID);
    final ParseResponse apiResponse = await response.query();

    if (apiResponse.success == true) {
      final jsonString = jsonDecode(jsonEncode(apiResponse.results?.first));
      AccountCredentialModal organizationModal = AccountCredentialModal.fromJson(jsonString);

      return NetworkResponse(true, organizationModal);
    } else {
      return NetworkResponse(
        false,
        null,
        message: 'Invalid response received from server! please try again in a minutes or two',
      );
    }
  } on SocketException {
    return NetworkResponse(
      false,
      null,
      message: "Unable to reach the internet! Please try again in  a minutes or two",
    );
  } on FormatException {
    return NetworkResponse(
      false,
      null,
      message: "Invalid response receded form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null, message: 'something went wrong please try again in a minute or two');
  }
}
