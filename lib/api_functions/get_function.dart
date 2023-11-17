import 'package:chat360/provider/category_list_provider.dart';
import 'package:chat360/provider/chat_room_provider.dart';
import 'package:chat360/provider/home_page_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/service/api_integration/receive/get_category_list.dart';
import 'package:chat360/service/api_integration/receive/get_chat_list.dart';
import 'package:chat360/service/api_integration/receive/get_chat_message.dart';
import 'package:chat360/widgets/popup/message_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/api_integration/receive/get_profile_details.dart';

getChatMessageResponse({required BuildContext context, required String messagedId}) async {
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
    scaffoldMessage(messages: response.message.toString(), context: context);
  }
  provider.setProcessing(false);
}

getChatListResponse({
  required BuildContext context,
}) async {
  var provider = Provider.of<HomePageProvider>(context, listen: false);
  var mainProvider = Provider.of<MainProvider>(context, listen: false);
  var response = await getChatList(userId: mainProvider.userID.toString(), selectedKeys: mainProvider.categoryList, context: context);
  if (response.isSuccessful!) {
    if (provider.messageList.length < response.data!.length) {
      provider.messageList.clear();
      provider.setLabourList(response.data!);
    } else {}
  } else {
    // ignore: use_build_context_synchronously
    scaffoldMessage(messages: response.message.toString(), context: context);
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
    // ignore: use_build_context_synchronously
    scaffoldMessage(messages: response.message.toString(), context: context);
  }
  provider.setProcessing(false);
}

getProfileDetailsResponse({required BuildContext context}) async {
  var mainProvider = Provider.of<MainProvider>(context, listen: false);
  final response = await getProfileDetailsUser(
    tableName: mainProvider.accountType.toString(),
    userID: mainProvider.userID.toString(),
  );
  if (response.isSuccessful!) {
    // mainProvider.createCategoryList(categoryTypes: response.data!.categoryTypes);
    // mainProvider.getCategory();
    // mainProvider.setCategoryList(response.data!.categoryTypes);
  }
}
