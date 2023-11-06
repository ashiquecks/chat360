import 'package:flutter/material.dart';

Widget textColumCard({
  required String textCount,
  required String textLabel,
}) {
  return Column(
    children: [
      Text(
        textCount,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text(textLabel),
    ],
  );
}
