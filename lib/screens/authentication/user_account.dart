import 'package:chat360/api_functions/create_function.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/widgets/button/button_widget.dart';
import 'package:chat360/widgets/text_field.dart/text_filed_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            labelName: mainProvider.phoneNumber.text,
          ),
          mainTextFieldDisable(
            labelName: mainProvider.password.text,
          ),
          loginButton(
            context: context,
            buttonText: "Continue",
            buttonAction: () {
              createUserAccountResponse(
                userName: userName.text,
                context: context,
              );
            },
          )
        ],
      ),
    );
  }
}
