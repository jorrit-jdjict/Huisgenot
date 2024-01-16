// user_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<User?> getUserById(String userId) async {
    try {
      var snapshot = await _firestore.collection(collection).doc(userId).get();

      if (snapshot.exists) {
        return User.fromDocument(snapshot);
      } else {
        print('Gebruiker met ID $userId niet gevonden.');
        return null;
      }
    } catch (e) {
      print('Fout bij ophalen van gebruiker uit Firebase: $e');
      return null;
    }
  }

  Future<void> addUserToFirebase(User user) async {
    try {
      await _firestore.collection(collection).add(user.toJson());
      print(
          'Gebruiker toegevoegd aan Firebase: ${user.firstName} ${user.lastName}');
    } catch (e) {
      print('Fout bij toevoegen van gebruiker aan Firebase: $e');
    }
  }

  Future<List<User>> getUsersInHouse(String houseId) async {
    try {
      var snapshot = await _firestore
          .collection(collection)
          .where('house_id', isEqualTo: houseId)
          .get();

      return snapshot.docs.map((doc) => User.fromDocument(doc)).toList();
    } catch (e) {
      print('Fout bij ophalen van gebruikers in huis uit Firebase: $e');
      return [];
    }
  }
}
