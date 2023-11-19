import 'package:chat360/modal/chat_message_modal.dart';
import 'package:chat360/provider/chat_room_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

messageBox({
  required String type,
  required String messageText,
  required int index,
  required ChatRoomProvider value,
  required ChatMessageModal response,
  required BuildContext context,
}) {
  switch (type) {
    case 'text':
      {
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color(0xfff7f7f8),
          ),
          child: Text(messageText),
        );
      }
    case 'image':
      {
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color(0xfff7f7f8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(messageText),
          ),
        );
      }
    case 'link':
      {
        return Container(
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
        );
      }
    default:
      {
        return const SizedBox();
      }
  }
}
