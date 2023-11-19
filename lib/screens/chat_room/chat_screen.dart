import 'package:chat360/api_functions/create_function.dart';
import 'package:chat360/modal/chat_message_modal.dart';
import 'package:chat360/provider/chat_room_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/resources/colors.dart';
import 'package:chat360/widgets/card/card_widget.dart';
import 'package:chat360/widgets/chat_box/chatlist_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final chatRoomProvider = Provider.of<ChatRoomProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        chatRoomProvider.messageList.clear();
        mainProvider.setMessageId('');
        Navigator.pushNamed(context, 'home_screen');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: white,
          backgroundColor: primaryColor,
          elevation: 12,
          title: const Text("User Name"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: white,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Consumer<ChatRoomProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.messageList.length,
                  itemBuilder: (context, index) {
                    ChatMessageModal responsePost = value.getPostByIndex(index);
                    return chatListItemBox(
                      index: index,
                      value: value,
                      response: responsePost,
                      mainProvider: mainProvider,
                      context: context,
                    );
                  },
                );
              },
            ),
            mainProvider.createReply? Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: replyMessageCard(
                imageButton: true,
                controller: mainProvider.chatLink,
                sendMessage: () async {
                  createMessageResponse(
                    context: context,
                    messageId: mainProvider.messageId.toString(),
                    isFirst: true,
                  );
                },
                getImage: () {
                  Navigator.pushNamed(context, 'image_chat');
                },
                navigateScreen: 'chat_screen',
              ),
            ): const SizedBox()
          ],
        ),
      ),
    );
  }
}
