import 'package:chat360/modal/chat_message_modal.dart';
import 'package:chat360/provider/chat_room_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/resources/app_them.dart';
import 'package:flutter/material.dart';

Widget textColumCard({
  required String textCount,
  required String textLabel,
}) {
  return Column(
    children: [
      Text(
        textCount,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text(textLabel),
    ],
  );
}

Widget messageBoxIconCard({
  required MainProvider mainProvider,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 15, top: 5),
    child: Row(
      children: [
        Image.asset(
          'assets/images/more.png',
          width: 30,
        ),
        InkWell(
          onTap: () {
            mainProvider.setCreateReply();
          },
          child: Image.asset(
            'assets/images/reply.png',
            width: 35,
          ),
        ),
      ],
    ),
  );
}

Widget imageMessageBox({
  required ChatMessageModal response,
}) {
  return Container(
    decoration: decorationMessageBox,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Image.network(response.photoMessage.url),
        ),
        response.message !="" && response.message !=null ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            response.message,
          ),
        ) : const SizedBox(),
      ],
    ),
  );
}
