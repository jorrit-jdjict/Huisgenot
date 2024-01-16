import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/chat_model.dart';

class ChatController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final collection = "chat";

  Stream<List<Chat>> getChats() {
    return _firestore
        .collection(collection)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Chat.fromDocument(doc);
      }).toList();
    });
  }
}
