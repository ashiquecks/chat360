import 'dart:convert';
import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../modal/chat_message_modal.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<List<ChatMessageModal>>> getChatMessage(
    {required String messageId}) async {
  try {
    QueryBuilder<ParseObject> queryPublisher = QueryBuilder<ParseObject>(
      ParseObject('ChatMessage'),
    );
    queryPublisher.orderByAscending('createdAt');
    queryPublisher.whereEqualTo('messageId', messageId);
    final ParseResponse apiResponse = await queryPublisher.query();

    if (apiResponse.success == true) {
      final convertJson = await jsonDecode(apiResponse.results.toString());
      List<ChatMessageModal> chatMessageList = [];
      convertJson.forEach((e) {
        ChatMessageModal chatMessageResponse = ChatMessageModal.fromJson(e);
        chatMessageList.add(chatMessageResponse);
      });
      return NetworkResponse(true, chatMessageList);
    } else {
      return NetworkResponse(
        false,
        null,
        message:
            'Invalid response recived from server! please try again in a minutes or two',
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
          "Invalid response receved form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null,
        message: 'somthing went wrong please try again in a minute or two');
  }
}
