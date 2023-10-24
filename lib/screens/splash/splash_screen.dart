import 'package:chat360/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resourses/colors.dart';
import '../../service/shared_preference/shared_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userID;
  @override
  void initState() {
    super.initState();
    timerFunction();
  }

  getUsrId() {
    setState(() {
      userID = preferences!.getString("userId");
    });
  }

  timerFunction() {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 3), () {
      if (userID != null) {
        mainProvider.getUsrId(objectId: userID.toString());
        Navigator.pushNamed(context, 'home_screen');
      } else {
        Navigator.pushNamed(context, 'phone_verification');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset(
          "assets/images/chatmainlogo.png",
          width: 200,
        ),
      ),
    );
  }
}
