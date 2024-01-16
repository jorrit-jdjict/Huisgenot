import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String id;
  final String houseId1;
  final String houseId2;

  Chat({
    required this.id,
    required this.houseId1,
    required this.houseId2
  });

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'],
      houseId1: map['houseId1'],
      houseId2: map['houseId2'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'houseId1': houseId1,
      'houseId2': houseId2,
    };
  }

  factory Chat.fromDocument(DocumentSnapshot documentSnapshot) {
    String id = documentSnapshot.id;
    String houseId1 = documentSnapshot.get('house_id_1');
    String houseId2 = documentSnapshot.get('house_id_2');

    return Chat(
      id: id,
      houseId1: houseId1,
      houseId2: houseId2
    );
  }
}
