import 'package:flutter/material.dart';

import '../../resourses/colors.dart';

Widget messagecard({
  required TextEditingController controller,
  required void Function() sendMessage,
}) {
  return Card(
    shadowColor: secondaryColor,
    color: white,
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
      leading: const Icon(Icons.camera_alt),
      title: TextField(
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
  );
}
