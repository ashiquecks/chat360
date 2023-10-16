import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/widgets/card/list_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resourses/colors.dart';

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
