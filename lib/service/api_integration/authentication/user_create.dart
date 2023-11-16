import 'dart:convert';
import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../modal/account_credential_modal.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<AccountCredentialModal>> createUser({
  required String userId,
  required String userName,
  required String phoneNumber,
  required String password,
  required ParseFile profilePick,
  required Object categoryTypes,
  required String accountType,
  required bool creator,
}) async {
  ParseFile convertName = ParseFile(name: phoneNumber + userName, null);
  convertName.file = File(profilePick.file!.path);

  try {
    ParseObject response = ParseObject(accountType)
      ..set('userName', userName)
      ..set('phoneNumber', phoneNumber)
      ..set('password', password)
      ..set('profilePick', convertName)
      ..set('categoryTypes', categoryTypes)
      ..set('accountType', accountType)
      ..set('creator', creator);
    await response.save();

    QueryBuilder queryPublisher = QueryBuilder(response);
    ParseResponse userCreateResponse = await queryPublisher.query();

    if (userCreateResponse.success == true) {
      final jsonString = jsonDecode(jsonEncode(response));
      AccountCredentialModal responseData = AccountCredentialModal.fromJson(jsonString);

      return NetworkResponse(true, responseData, message: "success fully created");
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

Future<NetworkResponse<AccountCredentialModal>> updateUser({
  required String userId,
  required Object categoryTypes,
  required String accountType,
  required bool creator,
}) async {
  try {
    ParseObject response = ParseObject(accountType)
      ..objectId = userId
      ..set('categoryTypes', categoryTypes)
      ..set('creator', creator);
    await response.save();

    QueryBuilder queryPublisher = QueryBuilder(response);
    queryPublisher.whereEqualTo('objectId', userId);
    ParseResponse userCreateResponse = await queryPublisher.query();

    if (userCreateResponse.success == true) {
      final jsonString = jsonDecode(jsonEncode(userCreateResponse.results!.first));
      AccountCredentialModal responseData = AccountCredentialModal.fromJson(jsonString);

      return NetworkResponse(true, responseData, message: "success fully created");
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
