import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

import '../../modal/chat_message_modal.dart';
import '../../modal/message_modal.dart';

class LinkViewCard extends StatefulWidget {
  final MessageModal chatMessageModal;
  const LinkViewCard({super.key, required this.chatMessageModal});

  @override
  State<LinkViewCard> createState() => _LinkViewCardState();
}

class _LinkViewCardState extends State<LinkViewCard> {
  Map<String, PreviewData> datas = {};
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        key: ValueKey(widget.chatMessageModal),
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
                datas = {...datas, widget.chatMessageModal.message: data};
                // datas = {...datas, widget.chatMessageModal.chatMessage: data};
              });
            },
            // previewData: datas[responsePost.chatMessage],
            previewData: datas[widget.chatMessageModal.message],
            // text: responsePost.chatMessage,
            text: widget.chatMessageModal.message,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}
