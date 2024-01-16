import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/house_model.dart';

class HouseController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final collection = "house";

  Stream<List<House>> getHouses() {
    return _firestore
        .collection(collection)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return House.fromDocument(doc);
      }).toList();
    });
  }

  Future<House?> getHouseById(String houseId) async {
    try {
      var snapshot = await _firestore.collection(collection).doc(houseId).get();

      if (snapshot.exists) {
        return House.fromDocument(snapshot);
      } else {
        print('Huis met ID $houseId niet gevonden.');
        return null;
      }
    } catch (e) {
      print('Fout bij ophalen van huis uit Firebase: $e');
      return null;
    }
  }
}
