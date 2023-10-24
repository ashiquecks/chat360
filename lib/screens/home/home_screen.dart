import 'package:chat360/api_functions/chat_message_api.dart';
import 'package:chat360/modal/message_list_modal.dart';
import 'package:chat360/provider/home_page_provider.dart';
import 'package:chat360/service/api_integration/receve/get_message_list.dart';
import 'package:chat360/widgets/card/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../resourses/colors.dart';
import '../../widgets/popup/dialog_box_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> showExitPopup() async {
    return await showDialog(context: context, builder: (context) => exitDialogBox(context: context)) ?? false;
  }

  @override
  void initState() {
    final homepageProvider = Provider.of<HomePageProvider>(context, listen: false);
    super.initState();
    homepageProvider.getChatMessageResponse(context: context);
    // getMessageList();
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
                  gettMessageList();
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar.jpg"),
                ),
              ),
            )
          ],
        ),
        body: Consumer<HomePageProvider>(
          builder: (context, value, child) {
            return ListView.builder(
                itemCount: value.messageList.length,
                itemBuilder: (context, index) {
                  MessageListModal responsePost = value.getPostByIndex(index);
                  return messageListCard(
                      cardAction: () async {
                        await Navigator.pushNamed(context, 'chat_screen');
                      },
                      messageTitle: responsePost.chatTitle);
                });
          },
        ),
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
