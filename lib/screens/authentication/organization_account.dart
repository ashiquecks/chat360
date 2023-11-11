import 'dart:io';
import 'package:chat360/api_functions/create_function.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/widgets/button/button_widget.dart';
import 'package:chat360/widgets/text_field.dart/text_filed_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class OrganizationAccount extends StatefulWidget {
  const OrganizationAccount({super.key});

  @override
  State<OrganizationAccount> createState() => _OrganizationAccountState();
}

class _OrganizationAccountState extends State<OrganizationAccount> {
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
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text("Creator Account")),
      body: SingleChildScrollView(
        child: Column(
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
            mainTextFieldDisable(
              labelName: mainProvider.userName.toString(),
            ),
            mainTextField(
                labelName: "organization name",
                controller: mainProvider.organizationController),
            mainTextField(
                labelName: "gst number",
                controller: mainProvider.gstNumberController),
            mainTextField(
                labelName: "building number",
                controller: mainProvider.buildingNumberController),
            loginButton(
              context: context,
              buttonText: "Continue",
              buttonAction: () {
                mainProvider.setProfilePick(
                  ParseFile(
                    File(pickedFile!.path),
                  ),
                );
                Navigator.pushNamed(context, 'category_screen');
              },
            )
          ],
        ),
      ),
    );
  }
}
