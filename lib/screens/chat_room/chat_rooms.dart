import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/service/api_integration/receve/get_chat_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../api_functions/chat_message_api.dart';
import '../../modal/chat_message_modal.dart';
import '../../provider/chat_room_provider.dart';
import '../../resourses/colors.dart';
import '../../service/api_integration/create/create_chat_message.dart';
import '../../widgets/card/card_widget.dart';
import '../../widgets/popup/message_box.dart';
import '../../widgets/text/text_widgets.dart';

import 'package:flutter_link_previewer/flutter_link_previewer.dart';

class ChatRooms extends StatefulWidget {
  const ChatRooms({super.key});

  @override
  State<ChatRooms> createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  final TextEditingController chatLink = TextEditingController();

  @override
  void initState() {
    super.initState();
    // getChatMessageResponse(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildChatListView(),
    );
  }

  AppBar buildAppBar() {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    return AppBar(
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
    );
  }

  Widget buildChatListView() {
    return Stack(
      children: [
        Consumer<ChatRoomProvider>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.urls.length,
              itemBuilder: (context, index) {
                // ChatMessageModal responsePost = value.getPostByIndex(index);
                return buildChatItem(index, value);
              },
            );
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: buildMessageCard(),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: buildFilterButton(),
        ),
      ],
    );
  }

  Widget buildChatItem(int index, ChatRoomProvider value) {
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
            onLinkPressed: (values) {
              scafoldMessage(
                  messagetext: value.datas.toString(), context: context);
            },
            onPreviewDataFetched: (data) {
              value.setPreviewData(data, index);
            },
            previewData: value.datas[value.urls[index]],
            text: value.urls[index],
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }

  Widget buildMessageCard() {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    return messagecard(
      controller: chatLink,
      sendMessage: () async {
        final response = await createMessage(
          userId: mainProvider.userId.toString(),
          message: chatLink.text,
        );
        chatLink.clear();
        if (response.data != null) {
          mainProvider.setTextField("");
          getChatMessageResponse(context: context);
          scafoldMessage(
            messagetext: response.message.toString(),
            context: context,
          );
          getChatMessageResponse(context: context);
        } else {
          scafoldMessage(
            messagetext: response.message.toString(),
            context: context,
          );
        }
      },
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
