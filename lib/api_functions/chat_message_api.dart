import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/chat_room_provider.dart';
import '../service/api_integration/receve/get_chat_message.dart';
import '../widgets/text/text_widgets.dart';

getChatMessageResponse({
  required BuildContext context,
}) async {
  var provider = Provider.of<ChatRoomProvider>(context, listen: false);
  var response = await getChatMessage();
  if (response.isSuccessful!) {
    if (provider.messageList.length < response.data!.length) {
      provider.messageList.clear();
      provider.setLabourList(response.data!);
    } else {}
  } else {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: messageText(labelText: response.message.toString()),
        duration: Duration(seconds: 3),
      ));
  }
  provider.setProcessing(false);
}
