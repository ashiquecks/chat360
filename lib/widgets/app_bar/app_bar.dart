import 'package:flutter/material.dart';

import '../../resourses/colors.dart';

AppBar appBar({
  required BuildContext context,
}) {
  return AppBar(
    foregroundColor: white,
    backgroundColor: primaryColor,
    elevation: 12,
    title: TextButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, 'location_screen');
      },
      icon: Icon(
        Icons.location_pin,
        color: c1,
        size: 15,
      ),
      label: Text(
        "",
        style: TextStyle(color: white),
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.more_vert,
          color: white,
        ),
      ),
    ],
  );
}
