import 'package:chat360/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resourses/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    timerFunction();
  }

  timerFunction() {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.setUserCredentials();
    Future.delayed(const Duration(seconds: 3), () {
      if (mainProvider.userID != null && mainProvider.userID != "") {
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
