import 'dart:convert';
import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../modal/user_modal.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<UserModal>> createUser({
  required String userId,
  required String userName,
  required String phoneNumber,
  required String password,
  required ParseFile profilePick,
  required Object categoryTypes,
  required String accountType,
}) async {
  try {
    ParseObject? response;

    if (userId != "" && userId != null) {
      response = ParseObject('UserAccount')
        ..objectId = userId
        ..set('userName', userName)
        ..set('phoneNumber', phoneNumber)
        ..set('password', password)
        ..set('profilePick', profilePick)
        ..set('categoryTypes', categoryTypes)
        ..set('accountType', accountType);
      await response.save();
    } else {
      response = ParseObject('UserAccount')
        ..set('userName', userName)
        ..set('phoneNumber', phoneNumber)
        ..set('password', password)
        ..set('profilePick', profilePick)
        ..set('categoryTypes', categoryTypes)
        ..set('accountType', accountType);
      await response.save();
    }

    QueryBuilder queryPublisher = QueryBuilder(response!);
    final userCreateResponse = await queryPublisher.query();

    if (userCreateResponse.success == true) {
      final jsonString = jsonDecode(response.toString());
      UserModal responseData = UserModal.fromJson(jsonString);

      return NetworkResponse(true, responseData,
          message: "success fully created");
    } else {
      return NetworkResponse(
        false,
        null,
        message:
            'Invalid response received from server! please try again in a minutes or two',
      );
    }
  } on SocketException {
    return NetworkResponse(
      false,
      null,
      message:
          "Unable to reach the internet! Please try again in  a minutes or two",
    );
  } on FormatException {
    return NetworkResponse(
      false,
      null,
      message:
          "Invalid response receded form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null,
        message: 'something went wrong please try again in a minute or two');
  }
}
