import 'package:chat360/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';

ScaffoldMessengerState scafoldMessage({required String messagetext,required BuildContext context}) {
    return ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: messageText(labelText: messagetext),
        duration: Duration(seconds: 3),
      ));
  }