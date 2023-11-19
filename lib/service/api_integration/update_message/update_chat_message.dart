
import 'dart:convert';
import 'dart:io';
import 'package:chat360/modal/chat_message_modal.dart';
import 'package:chat360/service/server_response/server_response.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

Future<NetworkResponse<ChatMessageModal>> createExitingMessageText({
  required String userId,
  required String message,
  required String messageId,
}) async {
  final messageResponse = ParseObject('ChatMessage')
    ..set("userId", userId)
    ..set('message', message)
    ..set("messageId", messageId)
    ..set('creatorId', userId);
  await messageResponse.save();

  if (messageResponse.objectId != null) {
    final jsonString = jsonDecode(messageResponse.toString());
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


Future<NetworkResponse<ChatMessageModal>> createExitingMessageImage({
  required String userId,
  required String message,
  required String messageId,
  required ParseFile photo,
}) async {

  ParseFile convertNamePhoto = ParseFile(name: "image$userId", null);
  convertNamePhoto.file = File(photo.file!.path);
  final messageResponse = ParseObject('ChatMessage')
    ..set("userId", userId)
    ..set('message', message)
    ..set("messageId", messageId)
    ..set("photo", convertNamePhoto)
    ..set('creatorId', userId);
  await messageResponse.save();

  if (messageResponse.objectId != null) {
    final jsonString = jsonDecode(messageResponse.toString());
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
