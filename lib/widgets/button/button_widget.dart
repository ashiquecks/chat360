
import 'package:chat360/resources/colors.dart';
import 'package:flutter/material.dart';

// ElevatedButton(
//   onPressed: () async {
//     final url = Uri.parse("https://www.flipkart.com/");
//     if (!await launchUrl(url)) {
//       throw Exception('Could not launch $url');
//     }
//   },
//   child: const Text("Go Link"),
// ),



Widget verifyButton({
  required BuildContext context,
  required String buttonText,
  required void Function() buttonAction,
}) {
  return SizedBox(
    height: 50,
    width: MediaQuery.of(context).size.width,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
      onPressed: buttonAction,
      child: Text(
        buttonText,
        style: TextStyle(color: white),
      ),
    ),
  );
}

Widget loginButton({
  required BuildContext context,
  required String buttonText,
  required void Function() buttonAction,
}) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
        onPressed: buttonAction,
        child: Text(
          buttonText,
          style: TextStyle(color: white),
        ),
      ),
    ),
  );
}
