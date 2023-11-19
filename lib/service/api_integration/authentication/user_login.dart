import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'dart:convert';
import 'dart:io';
import '../../../modal/chat_message_modal.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<ChatMessageModal>> userLogin({
  required String userName,
  required String userToken,
}) async {
  try {
    final user = ParseUser(userName, userToken, null);

    var response = await user.login();

    if (response.statusCode == 200) {
      final jsonString = jsonEncode(response.results);
      ChatMessageModal responseData = ChatMessageModal.fromJson(jsonDecode(jsonString));

      return NetworkResponse(
        true,
        responseData,
      );
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
      message: "Invalid response received form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null, message: 'something went wrong please try again in a minute or two');
  }
}
