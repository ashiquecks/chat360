import 'package:chat360/modal/message_list_modal.dart';
import 'package:chat360/service/api_integration/receve/get_message_list.dart';
import 'package:flutter/material.dart';

import '../widgets/text/text_widgets.dart';

class HomePageProvider extends ChangeNotifier {
  bool _isProcessing = true;
  List<MessageListModal> _messageList = [];
  bool get isProcessing => _isProcessing;

  TextEditingController chatLink = TextEditingController();

  setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  List<MessageListModal> get messageList => _messageList;

  setLabourList(List<MessageListModal> list) {
    _messageList.addAll(list);
    notifyListeners();
  }

  mergeLabourList(List<MessageListModal> list) {
    _messageList = list;
    notifyListeners();
  }

  MessageListModal getPostByIndex(int index) => _messageList[index];

  getChatMessageResponse({
    required BuildContext context,
  }) async {
    var response = await gettMessageList();
    if (response.isSuccessful!) {
      if (messageList.length < response.data!.length) {
        messageList.clear();
        setLabourList(response.data!);
      } else {}
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: messageText(labelText: response.message.toString()),
          duration: Duration(seconds: 3),
        ));
    }
    setProcessing(false);
  }
}
