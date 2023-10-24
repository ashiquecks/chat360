import 'dart:convert';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../modal/message_modal.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<List<MessageModal>>> getChatMessage() async {
  QueryBuilder<ParseObject> queryPublisher = QueryBuilder<ParseObject>(
    ParseObject('ChatMessage'),
  )..orderByDescending('createdAt');
  final ParseResponse apiResponse = await queryPublisher.query();

  if (apiResponse.statusCode == 200 && apiResponse.result != null) {
    final jsonString = jsonEncode(apiResponse.results);
    final convertJson = await jsonDecode(jsonString);
    List<MessageModal> chatMessageList = [];
    convertJson.forEach((e) {
      MessageModal chatMessageResponse = MessageModal.fromJson(e);
      chatMessageList.add(chatMessageResponse);
    });
    return NetworkResponse(true, chatMessageList, message: "successfully get messages");
  } else {
    return NetworkResponse(
      false,
      null,
      message: 'Invalid response received from server! please try again in a minutes or two',
    );
  }
}
