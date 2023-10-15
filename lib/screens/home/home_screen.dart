import 'package:flutter/material.dart';
import '../../resourses/colors.dart';
import '../../widgets/popup/dialog_box_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> showExitPopup() async {
    return await showDialog(
            context: context,
            builder: (context) => exitDialogBox(context: context)) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          leadingWidth: 0,
          backgroundColor: primaryColor,
          title: SizedBox(
            width: 120,
            child: Image.asset("assets/images/chatsidelogo.png"),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.jpg"),
              ),
            )
          ],
        ),
        body: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.chat_bubble_outline,
                          color: white,
                        ),
                      ),
                      title: const Text(
                        "https://www.flipkart.com/realme-c51-carbon-black-64-gb/p/",
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Text("12-July"),
                    ),
                    const Divider(),
                  ],
                ),
              );
            }),
        floatingActionButton: CircleAvatar(
          maxRadius: 30,
          backgroundColor: primaryColor,
          child: IconButton(
            icon: Icon(
              Icons.chat_bubble_outline,
              color: white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'chat_room');
            },
          ),
        ),
      ),
    );
  }
}
