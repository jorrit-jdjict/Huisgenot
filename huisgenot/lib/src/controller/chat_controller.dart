import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huisgenot/src/model/chat_messages.dart';

class ChatController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendChatMessage(ChatMessages chatMessage, String groupChatId) async {
    // Convert the ChatMessages object to JSON
    Map<String, dynamic> messageData = chatMessage.toJson();

    // Add the message to the Firestore collection
    await _firestore.collection(groupChatId).add(messageData);
  }

  Stream<List<ChatMessages>> getChatMessages(String groupChatId, int limit) {
    return _firestore
        .collection(groupChatId)
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


