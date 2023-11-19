import 'dart:convert';
import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../modal/chat_message_modal.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<ChatMessageModal>> createMessageImage({
  required String userId,
  required String message,
  required Object categoryTypes,
  required int messageCount,
  required ParseFile photo,
}) async {
  ParseFile convertNamePhoto = ParseFile(name: "image$userId", null);
  convertNamePhoto.file = File(photo.file!.path);

  final listResponse = ParseObject('ChatList')
    ..set("userId", userId)
    ..set('chatTitle', message)
    ..set('categoryTypes', categoryTypes)
    ..set('messageCount', messageCount);
  await listResponse.save();

  if (listResponse.objectId != null) {
    final messageResponse = ParseObject('ChatMessage')
      ..set("message", message)
      ..set('userId', userId)
      ..set("messageId", listResponse.objectId)
      ..set("photo", convertNamePhoto)
      ..set('creatorId', userId);
    await messageResponse.save();

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

Future<NetworkResponse<ChatMessageModal>> createMessageText({
  required String userId,
  required String message,
  required Object categoryTypes,
  required int messageCount,
}) async {

  final listResponse = ParseObject('ChatList')
    ..set("userId", userId)
    ..set('chatTitle', message)
    ..set('categoryTypes', categoryTypes)
    ..set('messageCount', messageCount);
  await listResponse.save();

  if (listResponse.objectId != null) {
    final messageResponse = ParseObject('ChatMessage')
      ..set("message", message)
      ..set('userId', userId)
      ..set("messageId", listResponse.objectId)
      ..set('creatorId', userId);
    await messageResponse.save();

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
