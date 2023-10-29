import 'package:chat360/provider/home_page_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/service/api_integration/create/create_chat_message.dart';
import 'package:chat360/service/api_integration/receve/get_chat_list.dart';
import 'package:chat360/widgets/popup/message_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/chat_room_provider.dart';
import '../service/api_integration/receve/get_chat_message.dart';
import '../widgets/text/text_widgets.dart';

getChatMessageResponse(
    {required BuildContext context, required String messagedId}) async {
  var provider = Provider.of<ChatRoomProvider>(context, listen: false);

  var response = await getChatMessage(messageId: messagedId);

  if (response.isSuccessful!) {
    if (provider.messageList.length < response.data!.length) {
      provider.messageList.clear();
      provider.setLabourList(response.data!);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, 'chat_room');
    } else {}
  } else {
    // ignore: use_build_context_synchronously
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

createMessageResponse({
  required BuildContext context,
  required String messageId,
}) async {
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
  if (messageId != null && messageId != "") {
    final response = await createExitingMessage(
      userId: mainProvider.userId.toString(),
      message: mainProvider.chatLink.text,
      messageId: messageId,
    );
    mainProvider.chatLink.clear();
    if (response.data != null) {
      mainProvider.setTextField("");
      mainProvider.setMessageId(messageId);
      // ignore: use_build_context_synchronously
      getChatMessageResponse(context: context, messagedId: messageId);
      // ignore: use_build_context_synchronously
      getChatListResponse(context: context);
    }
    // ignore: use_build_context_synchronously
    scafoldMessage(
      messagetext: response.message.toString(),
      context: context,
    );
  } else {
    final response = await createMessage(
      userId: mainProvider.userId.toString(),
      message: mainProvider.chatLink.text,
    );
    mainProvider.chatLink.clear();
    if (response.data != null) {
      mainProvider.setTextField("");
      mainProvider.setMessageId(response.data!.messageId);
      // ignore: use_build_context_synchronously
      getChatMessageResponse(
          context: context, messagedId: response.data!.messageId);
      // ignore: use_build_context_synchronously
      getChatListResponse(context: context);
    }
    // ignore: use_build_context_synchronously
    scafoldMessage(
      messagetext: response.message.toString(),
      context: context,
    );
  }
}
