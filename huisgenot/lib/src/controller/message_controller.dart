import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huisgenot/src/model/chat_messages.dart';

class MessageController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendChatMessage(ChatMessages chatMessage) async {
    Map<String, dynamic> messageData = chatMessage.toJson();

    await _firestore.collection("messages").add(messageData);
  }

  Stream<List<ChatMessages>> getChatMessages(String chatId, int limit) {
    return _firestore
        .collection('messages')
        .where('chat_id', isEqualTo: chatId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return ChatMessages.fromDocument(doc);
      }).toList();
    });
  }

}


