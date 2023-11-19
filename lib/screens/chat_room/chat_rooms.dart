import 'package:chat360/api_functions/create_function.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/widgets/chat_box/chatlist_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../modal/chat_message_modal.dart';
import '../../provider/chat_room_provider.dart';
import '../../resources/colors.dart';
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: messageCard(
                imageButton: true,
                controller: mainProvider.chatLink,
                sendMessage: () async {
                  createMessageResponse(
                    context: context,
                    messageId: mainProvider.messageId.toString(), isFirst: true,
                  );
                },
                getImage: () {
                  Navigator.pushNamed(context, 'image_chat');
                  Future.delayed(const Duration(seconds: 2), () {
                    mainProvider.setTextField("images");
                  });
                },
                navigateScreen: 'chat_room',
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

  Widget buildChatItem(int index, ChatRoomProvider value, ChatMessageModal response) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          response.photoMessage.url != ""
              ? Container(
                  key: ValueKey([index]),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Color(0xfff7f7f8),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: Image.network(response.photoMessage.url),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          response.message,
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  key: ValueKey([index]),
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
                      // onLinkPressed: (link) async {
                      //   final url = Uri.parse(link);
                      //   await launchUrl(url);
                      // },
                    ),
                  ),
                ),
        ],
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
