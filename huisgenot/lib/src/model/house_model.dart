import 'package:cloud_firestore/cloud_firestore.dart';

class House {
  final String id;
  final String name;
  final String address;
  final String description;

  House({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
  });

  factory House.fromMap(Map<String, dynamic> map) {
    return House(
        id: map['id'],
        name: map['name'],
        address: map['address'],
        description: map['description']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'description': description,
    };
  }

  factory House.fromDocument(DocumentSnapshot documentSnapshot) {
    String id = documentSnapshot.id;
    String name = documentSnapshot.get('name');
    String address = documentSnapshot.get('address');
    String description = documentSnapshot.get('description');

    return House(
        id: id,
        name: name,
        address: address,
        description: description
    );
  }
}