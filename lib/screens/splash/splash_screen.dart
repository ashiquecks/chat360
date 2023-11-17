
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.setSharePreferencesData();
    Future.delayed(const Duration(seconds: 3), () async {
      if (mainProvider.userID != null && mainProvider.userID != "") {
        mainProvider.getCategoryList();
        // ignore: use_build_context_synchronously
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
