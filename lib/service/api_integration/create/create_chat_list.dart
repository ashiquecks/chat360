import 'dart:convert';
import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../modal/chat_message_modal.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<ChatMessageModal>> createChatList({required String userId, required String message}) async {
  final listResponse = ParseObject('ChatList')
    ..set("userId", userId)
    ..set('chatTitle', message);
  await listResponse.save();

  if (listResponse.objectId != null) {
    final messageResponse = ParseObject('ChatMessage')
      ..set("message", message)
      ..set('userId', userId)
      ..set("messageId", listResponse.objectId);
    await messageResponse.save();

    final jsonString = jsonDecode(jsonEncode(listResponse));
    ChatMessageModal responseData = ChatMessageModal.fromJson(jsonString);
    return NetworkResponse(true, responseData, message: "Successfully sent");
  } else {
    return NetworkResponse(
      false,
      null,
      message: 'Invalid response received from server! please try again in a minutes or two',
    );
  }
}

Future<NetworkResponse<ChatMessageModal>> updateChatList({required String userId, required String message,required String messageId}) async {
  final messageResponse = ParseObject('ChatMessage')
    ..set("message", message)
    ..set('userId', userId)
    ..set("messageId", messageId);
  await messageResponse.save();

  if (messageResponse.objectId != null) {
    final jsonString = jsonDecode(jsonEncode(messageResponse));
    ChatMessageModal responseData = ChatMessageModal.fromJson(jsonString);
    return NetworkResponse(true, responseData, message: "Successfully sent");
  } else {
    return NetworkResponse(
      false,
      null,
      message: 'Invalid response received from server! please try again in a minutes or two',
    );
  }
}
