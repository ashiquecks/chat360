import 'package:chat360/resources/colors.dart';
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

Widget boldText({
  required String labelText,
}) {
  return Text(
    labelText,
    style: const TextStyle(fontWeight: FontWeight.bold),
  );
}

Widget normalRichText({
  required String textOne,
  required String textTwo,
}) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      children: [
        TextSpan(
          text: textOne,
          style: const TextStyle(color: primaryColor),
        ),
        TextSpan(
          text: textTwo,
          style: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
