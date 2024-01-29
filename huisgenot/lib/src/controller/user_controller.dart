// user_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<void> addUserToFirebase(User user, id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('userId', user.id);
    await _prefs.setString('first_name', user.first_name);
    await _prefs.setString('house_id', id);
    try {
      DocumentReference documentReference =
          await _firestore.collection(collection).add(user.toJson());
      String documentId = documentReference.id;
      await _prefs.setString('userDocumentId', documentId);

      print(
          'Gebruiker toegevoegd aan Firebase: ${user.first_name} ${user.last_name} ${documentId}');
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
