import 'package:flutter/material.dart';

Widget messageText({
  required String labelText,
}) {
  return Text(
    labelText,
    style: const TextStyle(
      color: Colors.white,
    ),
  );
}
