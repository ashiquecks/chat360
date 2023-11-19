import 'dart:io';

import 'package:flutter/material.dart';

import '../../resources/colors.dart';

exitDialogBox({required BuildContext context}) {
  return AlertDialog(
    title: const Text('Exit App'),
    content: const Text('Do you want to exit an App?'),
    actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: white,
        ),
        onPressed: () => Navigator.of(context).pop(false),
        child: const Text('No'),
      ),
      const SizedBox(
        width: 20,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: white,
        ),
        onPressed: () => exit(0),
        child: const Text('Yes'),
      ),
    ],
  );
}
