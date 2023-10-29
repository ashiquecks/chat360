import 'package:chat360/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../api_functions/chat_message_api.dart';
import '../../modal/chat_message_modal.dart';
import '../../provider/chat_room_provider.dart';
import '../../resourses/colors.dart';
import '../../widgets/card/card_widget.dart';

import 'package:flutter_link_previewer/flutter_link_previewer.dart';

class ChatRooms extends StatefulWidget {
  const ChatRooms({super.key});

  @override
  State<ChatRooms> createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
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
          title: TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, 'location_screen');
            },
            icon: Icon(
              Icons.location_pin,
              color: c1,
              size: 15,
            ),
            label: Text(
              "Kozhokode",
              style: TextStyle(color: white),
            ),
          ),
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
                    return buildChatItem(index, value, responsePost);
                  },
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: messagecard(
                controller: mainProvider.chatLink,
                sendMessage: () async {
                  createMessageResponse(
                    context: context,
                    messageId: mainProvider.messageId.toString(),
                  );
                },
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: buildFilterButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChatItem(
      int index, ChatRoomProvider value, ChatMessageModal response) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        key: ValueKey([index]),
        margin: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Color(0xfff7f7f8),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: LinkPreview(
            onPreviewDataFetched: (data) async {
              await value.setPreviewData(data, index, response);
            },
            previewData: value.datas[response.message],
            text: response.message,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }

  Widget buildFilterButton() {
    return Card(
      elevation: 10,
      child: IconButton(
        icon: const Icon(Icons.edit_note),
        onPressed: () {
          Navigator.pushNamed(context, 'filter_screen');
        },
      ),
    );
  }
}
