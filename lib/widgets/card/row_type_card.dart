import 'package:chat360/resourses/colors.dart';
import 'package:chat360/widgets/card/mini_size_card.dart';
import 'package:flutter/material.dart';

Widget profileStatusCard({
  required BuildContext context,
}) {
  final widgetSize = MediaQuery.of(context).size;
  return Container(
    width: widgetSize.width,
    height: widgetSize.height / 8,
    margin: const EdgeInsets.all(15),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(boxShadow: const [
      BoxShadow(
          spreadRadius: 6,
          blurRadius: 6,
          color: Color.fromARGB(255, 214, 214, 214)),
    ], color: white, borderRadius: BorderRadius.circular(15)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textColumCard(textCount: '12', textLabel: 'message'),
        VerticalDivider(),
        textColumCard(textCount: '5', textLabel: 'report'),
        VerticalDivider(),
        textColumCard(textCount: '100', textLabel: 'inbox'),
      ],
    ),
  );
}
