import 'package:chat360/modal/chat_message_modal.dart';
import 'package:chat360/provider/chat_room_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/resources/app_them.dart';
import 'package:chat360/widgets/card/link_preview_card.dart';
import 'package:chat360/widgets/card/mini_size_card.dart';
import 'package:flutter/material.dart';

Widget chatListItemBox({
  required int index,
  required ChatRoomProvider value,
  required ChatMessageModal response,
  required MainProvider mainProvider,
  required BuildContext context,
}) {
  bool ownMessage = response.userId == mainProvider.userID;
  bool isImage = response.photoMessage.url != "";
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
        alignment: ownMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Container(
            decoration: decorationMessageBox,
            padding: const EdgeInsets.all(5),
            child: isImage
                ? imageMessageBox(response: response)
                : linkPreviewCard(
                    index: index,
                    value: value,
                    response: response,
                    mainProvider: mainProvider,
                    context: context,
                  ),
          ),
        ),
      ),
      ownMessage ? const SizedBox() : messageBoxIconCard(mainProvider: mainProvider),
    ],
  );
}
