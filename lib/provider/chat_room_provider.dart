import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/widgets/popup/message_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modal/chat_message_modal.dart';
import '../modal/message_modal.dart';
import '../service/api_integration/create/create_chat_list.dart';

class ChatRoomProvider extends ChangeNotifier {
  bool _isProcessing = true;
  List<MessageModal> _messageList = [];
  bool get isProcessing => _isProcessing;

  String? createMessageId;

  TextEditingController chatLink = TextEditingController();

  setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  setChatMessageId({required String chatMessageId}) {
    createMessageId = chatMessageId;
    notifyListeners();
  }

  List<MessageModal> get messageList => _messageList;

  setLabourList(List<MessageModal> list) {
    _messageList.addAll(list);
    notifyListeners();
  }

  mergeLabourList(List<MessageModal> list) {
    _messageList = list;
    notifyListeners();
  }

  MessageModal getPostByIndex(int index) => _messageList[index];

  createNewMessage({required BuildContext context}) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final response = await createChatList(
      userId: mainProvider.userID.toString(),
      message: chatLink.text,
    );
    chatLink.clear();
    if (response.data != null) {
      mainProvider.setTextField("");
      createMessageId = response.data!.objectId;
      scafoldMessage(messagetext: response.message.toString(), context: context);
    } else {
      scafoldMessage(messagetext: response.message.toString(), context: context);
    }
  }

  updateMessage({required BuildContext context}) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final response = await updateChatList(
      userId: mainProvider.userID.toString(),
      message: chatLink.text,
      messageId: createMessageId.toString(),
    );
    chatLink.clear();
    if (response.data != null) {
      mainProvider.setTextField("");
      setChatMessageId(chatMessageId: response.data!.objectId);
      scafoldMessage(messagetext: response.message.toString(), context: context);
    } else {
      scafoldMessage(messagetext: response.message.toString(), context: context);
    }
  }
}
