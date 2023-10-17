import 'package:flutter/material.dart';

Widget mainTextField({
  required String labelName,
  required TextEditingController controller,
}) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(labelName),
      ),
    ),
  );
}

Widget mainTextFieldDisable({
  required String labelName,
  // required TextEditingController controller,
}) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: TextFormField(
      enabled: false,
      // controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(labelName),
      ),
    ),
  );
}
