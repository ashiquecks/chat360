import 'package:chat360/resourses/colors.dart';
import 'package:flutter/material.dart';

Widget profileDetailsCard(
    {required BuildContext context,
    required String userName,
    required String userPhoneNumber}) {
  final widgetSize = MediaQuery.of(context).size;
  return Container(
    width: widgetSize.width,
    margin: const EdgeInsets.all(15),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(boxShadow: const [
      BoxShadow(
          spreadRadius: 6,
          blurRadius: 6,
          color: Color.fromARGB(255, 214, 214, 214)),
    ], color: white, borderRadius: BorderRadius.circular(15)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          title: Text(userName),
          trailing: Icon(
            Icons.verified,
            color: c1,
          ),
        ),
        const Divider(),
        ListTile(title: Text(userPhoneNumber)),
      ],
    ),
  );
}
