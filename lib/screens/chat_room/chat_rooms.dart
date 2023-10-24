import 'package:chat360/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_functions/chat_message_api.dart';
import '../../modal/chat_message_modal.dart';
import '../../provider/chat_room_provider.dart';
import '../../provider/home_page_provider.dart';
import '../../resourses/colors.dart';
import '../../service/api_integration/create/create_chat_list.dart';
import '../../service/api_integration/create/create_chat_message.dart';
import '../../service/shared_preference/shared_preference.dart';
import '../../widgets/card/card_widget.dart';
import '../../widgets/popup/message_box.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class ChatRooms extends StatefulWidget {
  const ChatRooms({super.key});

  @override
  State<ChatRooms> createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  String? userID;
  String? messageLisId;

  Map<String, PreviewData> datas = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final chatRoomProvider = Provider.of<ChatRoomProvider>(context, listen: false);
    final homepageProvider = Provider.of<HomePageProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        chatRoomProvider.setChatMessageId(chatMessageId: "");
        homepageProvider.getChatMessageResponse(context: context);
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
              mainProvider.userID.toString(),
              style: TextStyle(color: white),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                print(messageLisId);
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
            // Consumer<ChatRoomProvider>(
            //   builder: (context, value, child) {
            //     return ListView.builder(
            //       reverse: true,
            //       physics: const AlwaysScrollableScrollPhysics(),
            //       shrinkWrap: true,
            //       itemCount: value.messageList.length,
            //       itemBuilder: (context, index) {
            //         ChatMessageModal responsePost = value.getPostByIndex(index);
            //         return Align(
            //           alignment: Alignment.centerLeft,
            //           child: Container(
            //             key: ValueKey(responsePost),
            //             margin: const EdgeInsets.all(16),
            //             decoration: const BoxDecoration(
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(20),
            //               ),
            //               color: Color(0xfff7f7f8),
            //             ),
            //             child: ClipRRect(
            //               borderRadius: const BorderRadius.all(
            //                 Radius.circular(20),
            //               ),
            //               child: LinkPreview(
            //                 enableAnimation: true,
            //                 onPreviewDataFetched: (data) {
            //                   setState(() {
            //                     datas = {...datas, responsePost.chatMessage: data};
            //                   });
            //                 },
            //                 previewData: datas[responsePost.chatMessage],
            //                 text: responsePost.chatMessage,
            //                 width: MediaQuery.of(context).size.width,
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //     );
            //   },
            // ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: messagecard(
                controller: chatRoomProvider.chatLink,
                sendMessage: () async {
                  if (chatRoomProvider.createMessageId == null || chatRoomProvider.createMessageId == "") {
                    chatRoomProvider.createNewMessage(context: context);
                  } else {
                    chatRoomProvider.updateMessage(context: context);
                  }
                },
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Card(
                elevation: 10,
                child: IconButton(
                  icon: const Icon(Icons.edit_note),
                  onPressed: () {
                    Navigator.pushNamed(context, 'filter_screen');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
