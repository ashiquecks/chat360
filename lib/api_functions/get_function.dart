import 'package:chat360/provider/category_list_provider.dart';
import 'package:chat360/provider/chat_room_provider.dart';
import 'package:chat360/provider/home_page_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/service/api_integration/receve/get_category_list.dart';
import 'package:chat360/service/api_integration/receve/get_chat_list.dart';
import 'package:chat360/service/api_integration/receve/get_chat_message.dart';
import 'package:chat360/service/api_integration/receve/get_profile_details.dart';
import 'package:chat360/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  var mainProvider = Provider.of<MainProvider>(context, listen: false);
  var response = await getChatList(userId: mainProvider.userID.toString());
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

getCategoryListResponse({
  required BuildContext context,
}) async {
  var provider = Provider.of<CategoryListProvider>(context, listen: false);
  var response = await getCategoryList();
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

getProfileDetailsResponse({required BuildContext context}) async {
  var mainProvider = Provider.of<MainProvider>(context, listen: false);
  final response = await getProfileDetails(
    userID: mainProvider.userID.toString(),
  );
  if (response.isSuccessful!) {
    mainProvider.setCategoryList(response.data!.categoryTypes);
  }
}
