import 'package:chat360/resources/colors.dart';
import 'package:chat360/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';

class UserLaunch extends StatefulWidget {
  const UserLaunch({super.key});

  @override
  State<UserLaunch> createState() => _UserLaunchState();
}

class _UserLaunchState extends State<UserLaunch> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
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
                    Navigator.pushNamed(context, 'creator_account');
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
                    Navigator.pushNamed(context, 'user_account');

                  },
                  child: const Text(
                    "User Account",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),
            normalRichText(
              textOne: "Select Your Account Type? \n ",
              textTwo: "Continue to your space",
            ),
          ],
        ),
      ),
    );
  }
}
