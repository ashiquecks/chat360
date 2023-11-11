import 'package:chat360/api_functions/get_function.dart';
import 'package:chat360/provider/category_list_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/service/api_integration/authentication/organization_create.dart';
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
    {required BuildContext context, required ParseFile profilePick}) async {
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
  final response = await createUser(
    userName: mainProvider.userNameController.text,
    phoneNumber: mainProvider.phoneNumberController.text,
    password: mainProvider.passwordController.text,
    profilePick: profilePick,
    userId: mainProvider.userID.toString() ?? '',
  );
  if (response.isSuccessful == true) {
    scafoldMessage(messagetext: response.message.toString(), context: context);
    setUserData(
      userID: response.data!.objectId,
      userName: response.data!.userName,
      userPhone: response.data!.phoneNumber,
      profilePick: response.data!.profilePick.url,
      organizationName: '',
      organizationGst: '',
      organizationBuildingNumber: '',
    );

    mainProvider.setUserCredentials();
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, 'home_screen');
  } else {
    // ignore: use_build_context_synchronously
    scafoldMessage(messagetext: response.message.toString(), context: context);
  }
}

createOrganizationAccountResponse({
  required BuildContext context,
}) async {
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
  final categoryProvider =
      Provider.of<CategoryListProvider>(context, listen: false);
  final response = await createOrganization(
    profilePick: mainProvider.profilePick!,
    userID: mainProvider.userID.toString(),
    organizationName: mainProvider.organizationController.text,
    gstNumber: mainProvider.gstNumberController.text,
    buildingNumber: mainProvider.buildingNumberController.text,
    verifiedOrganization: false,
    userName: mainProvider.userName.toString(),
    phoneNumber: mainProvider.userPhone.toString(),
    password: "689568",
    categoryTypes: categoryProvider.categoryList,
  );
  if (response.isSuccessful == true) {
    mainProvider.clearCredential();
    // ignore: use_build_context_synchronously
    scafoldMessage(messagetext: response.message.toString(), context: context);
    setUserData(
      userID: response.data!.objectId,
      userName: response.data!.userName,
      userPhone: response.data!.phoneNumber,
      profilePick: response.data!.profilePick.url,
      organizationName: response.data!.organizationName,
      organizationGst: response.data!.gstNumber,
      organizationBuildingNumber: response.data!.buildingNumber,
    );

    mainProvider.setUserCredentials();
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, 'category_screen');
  } else {
    // ignore: use_build_context_synchronously
    scafoldMessage(messagetext: response.message.toString(), context: context);
  }
}
