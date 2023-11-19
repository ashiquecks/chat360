import 'dart:io';

import 'package:chat360/api_functions/create_function.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/widgets/button/button_widget.dart';
import 'package:chat360/widgets/text_field.dart/text_filed_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({super.key});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  // get image from phone gallery..
  Future<void> getImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        pickedFile = image;
      });
    }
  }

  XFile? pickedFile;

  bool loading = false;
  TextEditingController userName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              getImage();
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: pickedFile != null
                  ? Image.file(
                      File(pickedFile!.path),
                      fit: BoxFit.cover,
                    )
                  : const Center(
                      child: Icon(Icons.camera_alt),
                    ),
            ),
          ),
          mainTextField(labelName: "user name", controller: mainProvider.userNameController),
          mainTextFieldDisable(
            labelName: "phone number",
            controller: mainProvider.phoneNumberController,
          ),
          mainTextFieldDisable(
            labelName: "password",
            controller: mainProvider.passwordController,
          ),
          loginButton(
            context: context,
            buttonText: "Continue",
            buttonAction: () {
              mainProvider.setProfilePick(ParseFile(File(pickedFile!.path)));
              createUserAccountResponse(
                context: context,
                isCreator: false,
              );
            },
          )
        ],
      ),
    );
  }
}
