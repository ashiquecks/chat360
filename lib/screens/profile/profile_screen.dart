import 'package:flutter/material.dart';

import '../../resourses/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: widgetSize.height / 3,
            child: Stack(
              children: [
                Container(
                  width: widgetSize.width,
                  height: widgetSize.height / 3.5,
                  color: primaryColor,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 140,
                    height: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/avatar.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
