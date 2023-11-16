import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/resources/colors.dart';
import 'package:chat360/screens/category/category_screen.dart';
import 'package:chat360/widgets/button/button_widget.dart';
import 'package:chat360/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserLaunch extends StatefulWidget {
  const UserLaunch({super.key});

  @override
  State<UserLaunch> createState() => _UserLaunchState();
}

class _UserLaunchState extends State<UserLaunch> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/onbord_image.png"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {

                },
                child: const Text(
                  "Organization Account",
                  style: TextStyle(color: primaryColor),
                ),
              ),
              OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'category_screen');
                },
                child: const Text(
                  "User Account",
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
