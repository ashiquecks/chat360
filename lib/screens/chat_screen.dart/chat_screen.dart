import 'package:chat360/modal/message_modal.dart';
import 'package:chat360/service/api_integration/update/createExitingMessage.dart';
import 'package:chat360/widgets/app_bar/app_bar.dart';
import 'package:chat360/widgets/card/card_widget.dart';
import 'package:chat360/widgets/card/link_view_card.dart';
import 'package:chat360/widgets/popup/message_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:provider/provider.dart';
import '../../api_functions/chat_message_api.dart';
import '../../modal/chat_message_modal.dart';
import '../../provider/chat_room_provider.dart';
import '../../provider/main_provider.dart';
import '../../resourses/colors.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController chatLink = TextEditingController();

  Map<String, PreviewData> datas = {};

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
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
            mainProvider.userID.toString(),
            style: TextStyle(color: white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // print(messageLisId);
            },
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
                reverse: true,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.messageList.length,
                itemBuilder: (context, index) {
                  MessageModal responsePost = value.getPostByIndex(index);
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      key: ValueKey(responsePost),
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
                          enableAnimation: true,
                          onPreviewDataFetched: (data) {
                            setState(() {
                              datas = {...datas, responsePost.message: data};
                            });
                          },
                          previewData: datas[responsePost.message],
                          text: responsePost.message,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: messagecard(
              controller: chatLink,
              sendMessage: () async {
                final response = await createExistingMessage(
                  userID: 'user11',
                  chatMessage: chatLink.text,
                  chatMessages: [],
                );
                chatLink.clear();
                if (response.data != null) {
                  mainProvider.setTextField("");
                  scafoldMessage(messagetext: response.message.toString(), context: context);
                  getChatMessageResponse(context: context);
                } else {
                  scafoldMessage(messagetext: response.message.toString(), context: context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
