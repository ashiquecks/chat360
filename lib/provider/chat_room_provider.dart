import 'package:flutter/material.dart';
import '../modal/chat_message_modal.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class ChatRoomProvider extends ChangeNotifier {
  bool _isProcessing = true;
  List<ChatMessageModal> _messageList = [];
  bool get isProcessing => _isProcessing;

  final Map<String, PreviewData> datas = {};

  setPreviewData(PreviewData previewData, int index, ChatMessageModal modal) {
    datas[modal.message] = previewData;
    notifyListeners();
  }

  setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  List<ChatMessageModal> get messageList => _messageList;

  setChatMessageList(List<ChatMessageModal> list) {
    _messageList.addAll(list);
    notifyListeners();
  }

  mergeLabourList(List<ChatMessageModal> list) {
    _messageList = list;
    notifyListeners();
  }

  ChatMessageModal getPostByIndex(int index) => _messageList[index];
}
