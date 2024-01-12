import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huisgenot/src/model/chat_messages.dart';

import '../model/user_model.dart';

class UserController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final collection = "user";

  Stream<List<User>> getUsers() {
    return _firestore
        .collection(collection)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return User.fromDocument(doc);
      }).toList();
    });
  }
}

