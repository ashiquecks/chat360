import 'dart:io';

import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/widgets/card/list_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resources/colors.dart';

List<Map<String, dynamic>> categoryList = [
  {'title': 'mobile'},
  {'title': 'laptop'},
  {'title': 'camara'},
  {'title': 'kitchen items'},
  {'title': 'cleaning'}
];

Widget messagecard({
  required TextEditingController controller,
  required void Function() sendMessage,
}) {
  return Consumer<MainProvider>(
    builder: (context, modal, child) => Column(
      children: [
        modal.textFieldValue.isEmpty
            ? const SizedBox()
            : categoryListCard(categoryList: categoryList, context: context),
        Card(
          shadowColor: secondaryColor,
          color: white,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const Icon(Icons.camera_alt),
            title: TextField(
              onChanged: (value) {
                modal.setTextField(value);
              },
              minLines: 1,
              maxLines: 60,
              controller: controller,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Link Here"),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.send),
              onPressed: sendMessage,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget messageListCard({
  required void Function() cardAction,
  required String messageTitle,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 0,
    ),
    child: Column(
      children: [
        ListTile(
          onTap: cardAction,
          leading: CircleAvatar(
            maxRadius: 20,
            backgroundColor: primaryColor,
            child: Icon(
              Icons.chat_bubble_outline,
              color: white,
              size: 20,
            ),
          ),
          title: Text(
            messageTitle,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: const Text("12-July  12:30 AM"),
          trailing: Container(
            decoration: BoxDecoration(
                color: c1, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "12",
                style: TextStyle(color: white),
              ),
            ),
          ),
        ),
        const Divider(),
      ],
    ),
  );
}

Widget profileImageCard({
  required BuildContext context,
}) {
  final widgetSize = MediaQuery.of(context).size;
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
  return SizedBox(
    height: widgetSize.height / 4,
    child: Stack(
      children: [
        Container(
          width: widgetSize.width,
          height: widgetSize.height / 5,
          color: primaryColor,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 140,
            height: 140,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                mainProvider.profileImage.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget titleCard({required String title}) {
  return Card(
    elevation: 4,
    color: white,
    margin: EdgeInsets.all(10),
    child: ListTile(
      title: Text(
        title,
      ),
    ),
  );
}
