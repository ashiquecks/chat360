import 'package:flutter/material.dart';

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
          loginButton(
            context: context,
            buttonText: "Continue",
            buttonAction: () {
              Navigator.pushNamed(context, 'home_screen');
            },
          )
        ],
      ),
    );
  }
}
