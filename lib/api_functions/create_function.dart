import 'dart:io';
import 'package:chat360/api_functions/get_function.dart';
import 'package:chat360/modal/account_credential_modal.dart';
import 'package:chat360/modal/chat_message_modal.dart';
import 'package:chat360/provider/keyword_list_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/service/api_integration/authentication/organization_create.dart';
import 'package:chat360/service/api_integration/authentication/user_create.dart';
import 'package:chat360/service/api_integration/create/create_chat_message.dart';
import 'package:chat360/service/api_integration/update_message/update_chat_message.dart';
import 'package:chat360/service/server_response/server_response.dart';
import 'package:chat360/service/shared_preference.dart/shared_preference.dart';
import 'package:chat360/widgets/popup/message_box.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

createMessageResponse({
  required BuildContext context,
  required String messageId,
  required bool isFirst,
}) async {
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
  final categoryProvider = Provider.of<KeywordListProvider>(context, listen: false);

  NetworkResponse<ChatMessageModal> response;
  if (messageId != null && messageId != "") {
    if (mainProvider.pickedFile != null) {
      response = await createExitingMessageImage(
        userId: mainProvider.userID.toString(),
        message: mainProvider.chatLink.text,
        messageId: messageId,
        photo: ParseFile(File(mainProvider.pickedFile!.path)),
      );
    } else {
      response = await createExitingMessageText(
        userId: mainProvider.userID.toString(),
        message: mainProvider.chatLink.text,
        messageId: messageId,
      );
    }
  } else {
    if (mainProvider.pickedFile != null) {
      response = await createMessageImage(
        userId: mainProvider.userID.toString(),
        message: mainProvider.chatLink.text,
        categoryTypes: categoryProvider.categoryList,
        messageCount: 10,
        photo: ParseFile(File(mainProvider.pickedFile!.path)),
      );
    } else {
      response = await createMessageText( 
        userId: mainProvider.userID.toString(),
        message: mainProvider.chatLink.text,
        categoryTypes: categoryProvider.categoryList,
        messageCount: 10,
      );
    }
  }
  mainProvider.chatLink.clear();
  if (response.data != null) {
    mainProvider.setTextField("");
    mainProvider.setMessageId(response.data!.messageId);
    categoryProvider.categoryValue.clear();
    categoryProvider.categoryList.clear();
    mainProvider.clearImage();
    // ignore: use_build_context_synchronously
    getChatMessageResponse(context: context, messagedId: response.data!.messageId, isFirst: isFirst);
    // ignore: use_build_context_synchronously
    getChatListResponse(context: context);
  }
  // ignore: use_build_context_synchronously
  scaffoldMessage(
    messages: response.message.toString(),
    context: context,
  );
}

createUserAccountResponse({
  required BuildContext context,
  required bool isCreator,
}) async {
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
  final categoryProvider = Provider.of<KeywordListProvider>(context, listen: false);

  NetworkResponse<AccountCredentialModal>? response;

  if (mainProvider.userID != null && mainProvider.userID != "") {
    response = await updateUser(
      userId: mainProvider.userID.toString(),
      categoryTypes: categoryProvider.categoryList,
      accountType: mainProvider.accountType.toString(),
      creator: true,
    );
    // if update to creator account save selected category in your hive box
    mainProvider.setCategoryList(categoryTypes: response.data!.categoryTypes);
  } else {
    response = await createUser(
      userName: mainProvider.userNameController.text,
      phoneNumber: mainProvider.phoneNumberController.text,
      password: mainProvider.passwordController.text,
      profilePick: mainProvider.profilePick!,
      userId: mainProvider.userID.toString() ?? '',
      categoryTypes: categoryProvider.categoryList,
      accountType: 'UserAccount',
      creator: isCreator,
    );
  }

  if (response.isSuccessful == true) {
    setSharedPreferences(response);
    mainProvider.setSharePreferencesData();
    // ignore: use_build_context_synchronously
    scaffoldMessage(messages: response.message.toString(), context: context);
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, 'home_screen');
  } else {
    // ignore: use_build_context_synchronously
    scaffoldMessage(messages: response.message.toString(), context: context);
  }
}

createOrganizationAccountResponse({
  required BuildContext context,
}) async {
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
  final categoryProvider = Provider.of<KeywordListProvider>(context, listen: false);
  final response = await createOrganization(
    profilePick: mainProvider.profilePick!,
    userID: mainProvider.userID.toString(),
    organizationName: mainProvider.organizationController.text,
    gstNumber: mainProvider.gstNumberController.text,
    buildingNumber: mainProvider.buildingNumberController.text,
    verifiedOrganization: false,
    userName: mainProvider.userName.toString(),
    phoneNumber: mainProvider.phoneNumberController.text,
    password: mainProvider.passwordController.text,
    categoryTypes: categoryProvider.categoryList,
    accountType: 'OrganizationAccount',
    creator: true,
  );
  if (response.isSuccessful == true) {
    categoryProvider.categoryList.clear();
    // mainProvider.clearCredential();
    // ignore: use_build_context_synchronously
    scaffoldMessage(messages: response.message.toString(), context: context);
    setSharedPreferences(response);
    mainProvider.setSharePreferencesData();
    // Is Organization creator account you can save selected category in your hive box
    mainProvider.setCategoryList(categoryTypes: response.data!.categoryTypes);
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, 'home_screen');
  } else {
    // ignore: use_build_context_synchronously
    scaffoldMessage(messages: response.message.toString(), context: context);
  }
}
