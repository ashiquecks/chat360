import 'dart:convert';
import 'dart:io';
import 'package:chat360/modal/message_list_modal.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../modal/chat_message_modal.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<List<MessageListModal>>> gettMessageList() async {
  QueryBuilder<ParseObject> queryPublisher = QueryBuilder<ParseObject>(
    ParseObject('ChatList'),
  )..orderByDescending('createdAt');
  final ParseResponse apiResponse = await queryPublisher.query();

  if (apiResponse.statusCode == 200 && apiResponse.result != null) {
    final jsonString = jsonEncode(apiResponse.results);
    final convertJson = await jsonDecode(jsonString);
    List<MessageListModal> chatMessageList = [];
    convertJson.forEach((e) {
      MessageListModal chatMessageResponse = MessageListModal.fromJson(e);
      chatMessageList.add(chatMessageResponse);
    });
    return NetworkResponse(true, chatMessageList, message: " successfully get data");
  } else {
    return NetworkResponse(
      false,
      null,
      message: 'Invalid response recived from server! please try again in a minutes or two',
    );
  }
}
