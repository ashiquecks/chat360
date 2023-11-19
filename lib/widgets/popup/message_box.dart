import 'package:chat360/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';

ScaffoldMessengerState scaffoldMessage({required String messages,required BuildContext context}) {
    return ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: messageText(labelText: messages),
        duration: const Duration(seconds: 3),
      ));
  }