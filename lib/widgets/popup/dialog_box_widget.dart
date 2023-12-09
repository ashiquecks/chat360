import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';

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

showAlertDialogLoading({
  required BuildContext context,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        content: Card(
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Lottie.asset('assets/icons/loading.json'),
          ),
        ),
      );
    },
  );
}

showAlertDialogSuccess({
  required BuildContext context,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        content: Card(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Lottie.asset('assets/icons/success.json'),
          ),
        ),
      );
    },
  );
}

loadingAlertBox({
  required BuildContext context,
  required bool success,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        content: Card(
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Lottie.asset('assets/icons/loading.json'),
          ),
        ),
      );
    },
  );
}

// Lottie.network('https://lottie.host/720ea4bd-ed7e-486f-8567-b6cec7855638/A7QkRd3PZO.json')

successQuickAlert(BuildContext context) {
  QuickAlert.show(
    titleColor: Colors.green,
    context: context,
    title: "Account Created",
    confirmBtnColor: Colors.green,
    type: QuickAlertType.success,
    showConfirmBtn: false,
    onConfirmBtnTap: (){}
  );
}


// child: Lottie.network('https://lottie.host/93b18dc0-6135-410a-9385-613bba12953a/EWs2yiKpId.json'),