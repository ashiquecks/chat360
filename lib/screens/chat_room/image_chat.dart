import 'dart:io';
import 'package:chat360/api_functions/create_function.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/widgets/card/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageChat extends StatefulWidget {
  const ImageChat({super.key});

  @override
  State<ImageChat> createState() => _ImageChatState();
}

class _ImageChatState extends State<ImageChat> {
  @override
  void initState() {
    super.initState();
    getImageInitially();
  }

  getImageInitially() {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    if (mainProvider.pickedFile == null) {
      mainProvider.getImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        mainProvider.setTextField("");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            InkWell(
              onTap: () {
                mainProvider.getImage();
              },
              child: Container(
                width: widgetSize.width,
                height: widgetSize.height,
                margin: const EdgeInsets.all(15),
                child: mainProvider.pickedFile != null
                    ? Image.file(
                        File(mainProvider.pickedFile!.path),
                      )
                    : const SizedBox(),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: messageCard(
                imageButton: false,
                controller: mainProvider.chatLink,
                sendMessage: () async {
                  createMessageResponse(
                    context: context,
                    messageId: mainProvider.messageId.toString(),
                    isFirst: true,
                  );
                },
                getImage: () {
                  Navigator.pushNamed(context, 'image_chat');
                },
                navigateScreen: 'image_chat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
