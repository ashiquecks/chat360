import 'dart:convert';
import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../modal/chat_message_modal.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<ChatMessageModal>> createNewMessage(
    {required String userID, required String chatMessage, required List chatMessages}) async {
  try {
    final chatMessageResponse = ParseObject('ChatList')
      ..set('chatTitle', chatMessage)
      ..set('chatTime', DateTime.now())
      ..setAddAll('chatMessages', chatMessages);
    await chatMessageResponse.save();

    if (chatMessageResponse.objectId != null) {
      final jsonString = jsonEncode(chatMessageResponse);
      ChatMessageModal responseData = ChatMessageModal.fromJson(jsonDecode(jsonString));

      return NetworkResponse(
        true,
        responseData,
      );
    } else {
      return NetworkResponse(
        false,
        null,
        message: 'Invalid response recived from server! please try again in a minutes or two',
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
      message: "Invalid response receved form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null, message: 'somthing went wrong please try again in a minute or two');
  }
  throw Exception('Unexpected error occured!');
}
