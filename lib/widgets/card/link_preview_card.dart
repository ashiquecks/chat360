import 'package:chat360/modal/chat_message_modal.dart';
import 'package:chat360/provider/chat_room_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/resources/app_them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:url_launcher/url_launcher.dart';

Widget linkPreviewCard({
  required int index,
  required ChatRoomProvider value,
  required ChatMessageModal response,
  required MainProvider mainProvider,
  required BuildContext context,
}) {
  return Container(
    key: ValueKey([index]),
    decoration: decorationMessageBox,
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
        onLinkPressed: (link) async {
          final url = Uri.parse(link);
          await launchUrl(url);
        },
      ),
    ),
  );
}
