import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/service/api_integration/authentication/user_create.dart';
import 'package:chat360/service/shared_preference/shared_preference.dart';
import 'package:chat360/widgets/popup/message_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/button/button_widget.dart';
import '../../widgets/text_field.dart/text_filed_widgets.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({super.key});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  TextEditingController userName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Creator Account")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          mainTextField(labelName: "user name", controller: userName),
          mainTextFieldDisable(
            labelName: mainProvider.phoneNumber.toString(),
          ),
          mainTextFieldDisable(
            labelName: mainProvider.userPassword.text,
          ),
          loginButton(
            context: context,
            buttonText: "Continue",
            buttonAction: () async {
              final response = await createUser(
                userName: userName.text,
                phoneNumber: mainProvider.phoneNumber.toString(),
                password: mainProvider.userPassword.text,
              );
              if (response.isSuccessful == true) {
                scafoldMessage(messagetext: response.message.toString(), context: context);
                setUserData(
                  userId: response.data!.objectId,
                  userPassword: response.data!.password,
                  userName: response.data!.userName,
                  registerStatus: true,
                  userPhone: response.data!.phoneNumber,
                );
                Navigator.pushNamed(context, 'home_screen');
                mainProvider.getUsrId(objectId: response.data!.objectId);
              } else {
                scafoldMessage(messagetext: response.message.toString(), context: context);
              }
            },
          )
        ],
      ),
    );
  }
}
