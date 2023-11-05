import 'dart:convert';
import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../modal/chat_message_modal.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<ChatMessageModal>> createExistingMessage(
    {required String userID,
    required String chatMessage,
    required List<ParseObject> chatMessages}) async {
  try {
    final chatMessageResponse = ParseObject('MessageList')
      ..objectId = '0MSpL5ypRs'
      ..addRelation("messages", chatMessages);
    await chatMessageResponse.save();

    QueryBuilder queryPublisher = QueryBuilder(chatMessageResponse);
    final queryResponse = await queryPublisher.query();

    if (queryResponse.statusCode == 200 || queryResponse.success == true) {
      final jsonString = jsonDecode(queryResponse.toString());
      ChatMessageModal responseData = ChatMessageModal.fromJson(jsonString);

      return NetworkResponse(true, responseData, message: "Successfully sent");
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
          "Invalid response received form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null,
        message: 'something went wrong please try again in a minute or two');
  }
}
