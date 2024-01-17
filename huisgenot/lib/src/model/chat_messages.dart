import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages {
  String chatId;
  String userId;
  String timestamp;
  String content;

  ChatMessages({
    required this.chatId,
    required this.userId,
    required this.timestamp,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'chat_id': chatId,
      'user_id': userId,
      'timestamp': timestamp,
      'content': content,
    };
  }

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    String chatId = documentSnapshot.get('chat_id');
    String userId = documentSnapshot.get('user_id');
    String timestamp = documentSnapshot.get('timestamp');
    String content = documentSnapshot.get('content');

    return ChatMessages(
      chatId: chatId,
      userId: userId,
      timestamp: timestamp,
      content: content,
    );
  }
}
