import 'dart:convert';
import 'dart:io';
import 'package:chat360/modal/message_list_modal.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<List<MessageListModal>>> getChatList({
  required String userId,
  required Map<String, dynamic> selectedKeys,
  required BuildContext context,
}) async {
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
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
      final convertJsonUser = await jsonDecode(jsonEncode(userMessage.results));
      final convertJsonConnection = await jsonDecode(jsonEncode(connectedMessage.results));
      List<MessageListModal> messageList = [];

      if (convertJsonUser != null) {
        convertJsonUser.forEach((e) {
          MessageListModal responseUser = MessageListModal.fromJson(e);
          messageList.contains(responseUser) ? print("already created") : messageList.add(responseUser);
        });
      }

      convertJsonConnection.forEach((e) {
        MessageListModal responseUser = MessageListModal.fromJson(e);
        mainProvider.restFailedCount();
        selectedKeys.forEach((key, value) {
          if (responseUser.categoryTypes.containsValue(value)) {
            messageList.contains(responseUser) ? print("already created") : messageList.add(responseUser);
          } else {
            mainProvider.increaseFailedCount();
          }
          if (mainProvider.failedCount < 3) {
            messageList.contains(responseUser) ? messageList.remove(responseUser) : print("value exist");
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
