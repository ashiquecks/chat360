import 'package:chat360/widgets/button/button_widget.dart';
import 'package:chat360/widgets/text_field.dart/text_filed_widgets.dart';
import 'package:flutter/material.dart';

class CreatorAccount extends StatefulWidget {
  const CreatorAccount({super.key});

  @override
  State<CreatorAccount> createState() => _CreatorAccountState();
}

class _CreatorAccountState extends State<CreatorAccount> {
  TextEditingController userName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Creator Account")),
      body: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          mainTextField(labelName: "user name", controller: userName),
          mainTextField(labelName: "organization name", controller: userName),
          mainTextField(labelName: "gst number", controller: userName),
          mainTextField(labelName: "building number", controller: userName),
          loginButton(
            context: context,
            buttonText: "Continue",
            buttonAction: () {
              Navigator.pushNamed(context, 'category_screen');
            },
          )
        ],
      ),
    );
  }
}
