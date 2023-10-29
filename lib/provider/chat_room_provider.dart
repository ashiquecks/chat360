import 'package:flutter/material.dart';
import '../modal/chat_message_modal.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class ChatRoomProvider extends ChangeNotifier {
  bool _isProcessing = true;
  List<ChatMessageModal> _messageList = [];
  bool get isProcessing => _isProcessing;

  final Map<String, PreviewData> datas = {};

  // final List<String> urls = [
  //   'https://www.linkedin.com/posts/vignesh-radhakrishnan-he-him-6a28b7109_huddleglobal2023-jontyrhodes-ksum-activity-7122723355199205377-k59J?utm_source=share&utm_medium=member_android',
  //   'https://u24.gov.ua',
  //   'https://twitter.com/SpaceX/status/1564975288655630338',
  // ];

  setPreviewData(PreviewData previewData, int index, ChatMessageModal modal) {
    datas[modal.message] = previewData;
    // datas.update(modal.message, (existingData) => previewData);
    notifyListeners();
  }

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
