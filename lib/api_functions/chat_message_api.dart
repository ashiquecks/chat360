import 'package:chat360/provider/home_page_provider.dart';
import 'package:chat360/service/api_integration/receve/get_chat_list.dart';
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

getChatListResponse({
  required BuildContext context,
}) async {
  var provider = Provider.of<HomePageProvider>(context, listen: false);
  var response = await getChatList();
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
