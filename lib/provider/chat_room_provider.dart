import 'package:flutter/material.dart';
import '../modal/chat_message_modal.dart';

class ChatRoomProvider extends ChangeNotifier {
  bool _isProcessing = true;
  List<ChatMessageModal> _messageList = [];
  bool get isProcessing => _isProcessing;

  setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  List<ChatMessageModal> get messageList => _messageList;

  setLabourList(List<ChatMessageModal> list) {
    _messageList.addAll(list);
    notifyListeners();
  }

  mergeLabourList(List<ChatMessageModal> list) {
    _messageList = list;
    notifyListeners();
  }

  ChatMessageModal getPostByIndex(int index) => _messageList[index];
}
