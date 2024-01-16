import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages {
  String idFrom;
  String idTo;
  String timestamp;
  String content;

  ChatMessages({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'idFrom': idFrom,
      'idTo': idTo,
      'timestamp': timestamp,
      'content': content,
    };
  }

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    String idFrom = documentSnapshot.get('idFrom');
    String idTo = documentSnapshot.get('idTo');
    String timestamp = documentSnapshot.get('timestamp');
    String content = documentSnapshot.get('content');

    return ChatMessages(
      idFrom: idFrom,
      idTo: idTo,
      timestamp: timestamp,
      content: content,
    );
  }
}
