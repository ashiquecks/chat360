import 'package:flutter/material.dart';
import '../modal/message_list_modal.dart';

class HomePageProvider extends ChangeNotifier {
  bool _isProcessing = true;
  List<MessageListModal> _messageList = [];
  bool get isProcessing => _isProcessing;

  setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  List<MessageListModal> get messageList => _messageList;

  setMessageList(List<MessageListModal> list) {
    _messageList.addAll(list);
    notifyListeners();
  }

  mergeLabourList(List<MessageListModal> list) {
    _messageList = list;
    notifyListeners();
  }

  MessageListModal getPostByIndex(int index) => _messageList[index];
}
