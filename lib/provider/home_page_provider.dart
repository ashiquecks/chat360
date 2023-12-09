import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../modal/message_list_modal.dart';

class HomePageProvider extends ChangeNotifier {
  bool _isProcessing = true;
  List<MessageListModal> _messageList = [];
  bool get isProcessing => _isProcessing;

  List<ParseObject> taskList = [];
  StreamController<List<ParseObject>> streamController = StreamController();

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
