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
}


