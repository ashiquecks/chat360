import 'package:chat360/api_functions/get_function.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/service/api_integration/authentication/user_create.dart';
import 'package:chat360/service/api_integration/create/create_chat_message.dart';
import 'package:chat360/service/shared_preference.dart/shared_preference.dart';
import 'package:chat360/widgets/popup/message_box.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

createMessageResponse({
  required BuildContext context,
  required String messageId,
}) async {
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
  if (messageId != null && messageId != "") {
    final response = await createExitingMessage(
      userId: mainProvider.userID.toString(),
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
      userId: mainProvider.userID.toString(),
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

createUserAccountResponse(
    {required String userName,
    required BuildContext context,
    required ParseFile profilePick}) async {
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
  final response = await createUser(
    userName: userName,
    phoneNumber: mainProvider.phoneNumber.text,
    password: mainProvider.password.text,
    profilePick: profilePick,
  );
  if (response.isSuccessful == true) {
    scafoldMessage(messagetext: response.message.toString(), context: context);
    setUserData(
      userID: response.data!.objectId,
      userName: response.data!.userName,
      userPhone: response.data!.phoneNumber,
      profilePick: response.data!.profilePick.url,
    );

    mainProvider.setUserCredentials();
    Navigator.pushNamed(context, 'home_screen');
  } else {
    scafoldMessage(messagetext: response.message.toString(), context: context);
  }
}
