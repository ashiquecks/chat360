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
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'profile_screen');
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar.jpg"),
                ),
              ),
            )
          ],
        ),
        body: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () async{
                        await Navigator.pushNamed(context, 'chat_room');
                      },
                      leading: CircleAvatar(
                        maxRadius: 20,
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
                      subtitle: const Text("12-July  12:30 AM"),
                      trailing: Container(
                        decoration: BoxDecoration(
                            color: c1, borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "12",
                            style: TextStyle(color: white),
                          ),
                        ),
                      ),
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
            onPressed: () async {
              await Navigator.pushNamed(context, 'chat_room');
            },
          ),
        ),
      ),
    );
  }
}
