// import 'package:chat360/modal/message_modal.dart';
// import 'package:parse_server_sdk/parse_server_sdk.dart';

// class MessagePO extends ParseObject implements ParseCloneable {
//   MessagePO() : super(keyTableName);

//   MessagePO.clone() : this();

//   /// Looks strangely hacky but due to Flutter not using reflection, we have to
//   /// mimic a clone
//   @override
//   clone(Map<String, dynamic> map) => MessagePO.clone()..fromJson(map);

//   static const String keyTableName = 'ChatMessage';
//   static const String keyMessage = 'message';
//   static const String keyUserId = 'userId';

//   String? get message => get<String>(keyMessage);

//   String? get userId => get<String>(keyUserId);

//   set message(String? message) {
//     if (message != null) {
//       set<String>(keyMessage, message);
//     }
//   }

//   set userId(String? userId) {
//     if (userId != null) {
//       set<String>(keyUserId, userId);
//     }
//   }

//   MessagePO.fromMessages(MessageModal messageModal) : super(keyTableName) {
//     if (messageModal.id != null) {
//       this.objectId = messageModal.id;
//     }
//     if (messageModal.message != null) {
//       this.message = messageModal.message;
//     }
//     if (messageModal.userId != null) {
//       this.userId = messageModal.userId;
//     }
//   }

//   MessageModal toMessage() {
//     return MessageModal(id: this.objectId, message: this.message, userId: this.userId);
//   }
// }
