import 'package:chat360/widgets/text/text_widgets.dart';
import 'package:flutter/material.dart';

class CreatorApproval extends StatefulWidget {
  const CreatorApproval({super.key});

  @override
  State<CreatorApproval> createState() => _CreatorApprovalState();
}

class _CreatorApprovalState extends State<CreatorApproval> {
  @override
  void initState() {
    super.initState();
    timerFunction();
  }

  timerFunction() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, 'home_screen');
    });
  }

  bool refresh = false;

  onRefresh() {
    setState(() {
      refresh = !refresh;
    });
    Future.delayed(
        const Duration(
          seconds: 5,
        ), () {
      setState(() {
        refresh = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/aproval.png"),
            normalRichText(
              textOne: "Your creator Account waiting for  ",
              textTwo: "Approval",
            ),
          ],
        ),
      ),
      floatingActionButton: CircleAvatar(
        child: refresh
            ? const Padding(
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator(),
              )
            : IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  onRefresh();
                },
              ),
      ),
    );
  }
}
