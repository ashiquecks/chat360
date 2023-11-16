import 'dart:convert';
import 'dart:io';
import 'package:chat360/modal/message_list_modal.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<List<MessageListModal>>> getChatList({
  required String userId,
  required Map<String, dynamic> selectedKeys,
}) async {
  try {
    QueryBuilder<ParseObject> userMessageResponse = QueryBuilder<ParseObject>(
      ParseObject('ChatList'),
    );

    QueryBuilder<ParseObject> connectMessageResponse = QueryBuilder<ParseObject>(
      ParseObject('ChatList'),
    );
    userMessageResponse.whereEqualTo('userId', userId);

    ParseResponse userMessage = await userMessageResponse.query();

    ParseResponse connectedMessage = await connectMessageResponse.query();

    if (userMessage.success == true) {
      final convertJsonUser = await jsonDecode(userMessage.results.toString());
      final convertJsonConnection = await jsonDecode(connectedMessage.results.toString());
      List<MessageListModal> messageList = [];
      convertJsonUser.forEach((e) {
        MessageListModal responseUser = MessageListModal.fromJson(e);
        messageList.contains(responseUser) ? print("already created") : messageList.add(responseUser);
      });

      convertJsonConnection.forEach((e) {
        MessageListModal responseUser = MessageListModal.fromJson(e);
        selectedKeys.forEach((key, value) {
          if (responseUser.categoryTypes.containsValue(value)) {
            messageList.contains(responseUser) ? print("already created") : messageList.add(responseUser);
          }
        });
      });
      return NetworkResponse(true, messageList);
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
      message: "Invalid response receved form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null, message: 'somthing went wrong please try again in a minute or two');
  }
}
