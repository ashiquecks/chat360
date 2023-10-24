// import 'package:chat360/modal/message_list_modal.dart';
// import 'package:chat360/modal/message_modal.dart';
// import 'package:chat360/service/parse_object.dart/message_po.dart';
// import 'package:parse_server_sdk/parse_server_sdk.dart';

// class MessageListPO extends ParseObject implements ParseCloneable {
//   MessageListPO() : super(keyTableName);

//   MessageListPO.clone() : this();

//   /// Looks strangely hacky but due to Flutter not using reflection, we have to
//   /// mimic a clone
//   @override
//   clone(Map<String, dynamic> map) => MessageListPO.clone()..fromJson(map);

//   static const String keyTableName = 'MessageList';
//   static const String keyChatTitle = 'chatTitle';
//   static const String keyUserId = 'userId';
//   static const String keyMessage = 'messages';

//   String? get chatTitle => get<String>(keyChatTitle);

//   String? get userId => get<String>(keyUserId);

//   MessagePO? get messages => get<MessagePO>(keyMessage);

//   set chatTitle(String? chatTitle) {
//     if (chatTitle != null) {
//       set<String>(keyChatTitle, chatTitle);
//     }
//   }

//   set userId(String? userId) {
//     if (userId != null) {
//       set<String>(keyUserId, userId);
//     }
//   }

//   set messages(MessagePO? messages) {
//     if (messages != null) {
//       set<MessagePO>(keyMessage, messages);
//     }
//   }

//   MessageListPO.fromMessageList(MessageListModal messageModal) : super(keyTableName) {
//     // if (messageModal.id != null) {
//     //   this.objectId = messageModal.id;
//     // }
//     if (messageModal.chatTitle != null) {
//       this.chatTitle = messageModal.chatTitle;
//     }
//     if (messageModal.userId != null) {
//       this.userId = messageModal.userId;
//     }
//     // if (messageModal.messages != null) {
//     //   MessagePO messages = MessagePO.fromMessages(messageModal.messages!);
//     //   if (messages != null) {
//     //     this.messages = messages;
//     //   }
//     // }
//   }

//   // MessageListModal toMessageList() {
//   //   return MessageListModal(
//   //     id: this.objectId,
//   //     chatTitle: this.chatTitle,
//   //     userId: this.userId,
//   //     messages: this.messages?.toMessage(),
//   //   );
//   // }
// }
