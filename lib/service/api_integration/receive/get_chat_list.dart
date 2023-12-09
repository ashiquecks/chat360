import 'dart:convert';
import 'dart:io';
import 'package:chat360/modal/message_list_modal.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<List<MessageListModal>>> getChatList({
  required String userId,
  required Map<String, dynamic> selectedKeys,
  required BuildContext context,
}) async {
  try {
    QueryBuilder<ParseObject> messageResponse = QueryBuilder<ParseObject>(
      ParseObject('ChatList'),
    );
    if (userId != "") {
      messageResponse.whereEqualTo('userId', userId);
    }
    if (selectedKeys.isNotEmpty) {
      messageResponse.whereArrayContainsAll('categoryTypes', [selectedKeys]);
    }

    ParseResponse message = await messageResponse.query();

    if (message.success == true) {
      final jsonMessageList = await jsonDecode(jsonEncode(message.results));

      List<MessageListModal> messageList = [];

      jsonMessageList.forEach((e) {
        MessageListModal responseUser = MessageListModal.fromJson(e);
        messageList.add(responseUser);
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
      message: "Invalid response received form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null, message: 'something went wrong please try again in a minute or two');
  }
}


// Future<NetworkResponse<List<MessageListModal>>> getChatList({
//   required String userId,
//   required Map<String, dynamic> selectedKeys,
//   required BuildContext context,
// }) async {
//   final mainProvider = Provider.of<MainProvider>(context, listen: false);
//   try {
//     QueryBuilder<ParseObject> userMessageResponse = QueryBuilder<ParseObject>(
//       ParseObject('ChatList'),
//     );

//     QueryBuilder<ParseObject> connectMessageResponse = QueryBuilder<ParseObject>(
//       ParseObject('ChatList'),
//     );
//     userMessageResponse.whereEqualTo('userId', userId);

//     ParseResponse userMessage = await userMessageResponse.query();

//     ParseResponse connectedMessage = await connectMessageResponse.query();

//     if (userMessage.success == true) {
//       final convertJsonUser = await jsonDecode(jsonEncode(userMessage.results));
//       final convertJsonConnection = await jsonDecode(jsonEncode(connectedMessage.results));

//       List<MessageListModal> messageList = [];

//       if (convertJsonUser != null) {
//         convertJsonUser.forEach((e) {
//           MessageListModal responseUser = MessageListModal.fromJson(e);
//           if (!messageList.contains(responseUser)) {
//             messageList.add(responseUser);
//           }
//         });
//       }

//       convertJsonConnection.forEach((e) {
//         mainProvider.failedList.clear();
//         MessageListModal responseUser = MessageListModal.fromJson(e);
//         selectedKeys.forEach((key, value) {
//           if (!responseUser.categoryTypes.containsKey(key) && responseUser.userId == userId) {
//             mainProvider.increaseFailedCount(0);
//           }
//           if (mainProvider.failedList.length < 3) {
//             messageList.add(responseUser);
//           }
//         });
//       });
//       return NetworkResponse(true, messageList);
//     } else {
//       return NetworkResponse(
//         false,
//         null,
//         message: 'Invalid response received from server! please try again in a minutes or two',
//       );
//     }
//   } on SocketException {
//     return NetworkResponse(
//       false,
//       null,
//       message: "Unable to reach the internet! Please try again in  a minutes or two",
//     );
//   } on FormatException {
//     return NetworkResponse(
//       false,
//       null,
//       message: "Invalid response received form the server! Please try again in a minutes or two",
//     );
//   } catch (e) {
//     return NetworkResponse(false, null, message: 'something went wrong please try again in a minute or two');
//   }
// }
