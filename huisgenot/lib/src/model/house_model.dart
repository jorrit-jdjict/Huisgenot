import 'package:cloud_firestore/cloud_firestore.dart';

class House {
  final String id;
  final String name;
  final String address;
  final String description;
  final double lat;
  final double lng;

  House({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.lat,
    required this.lng
  });

  factory House.fromMap(Map<String, dynamic> map) {
    return House(
        id: map['id'],
        name: map['name'],
        address: map['address'],
        description: map['description'],
        lat: map['lat'],
        lng: map['lng']

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'description': description,
      'lat': lat,
      'lng': lng,
    };
  }

  factory House.fromDocument(DocumentSnapshot documentSnapshot) {
    String id = documentSnapshot.id;
    String name = documentSnapshot.get('name');
    String address = documentSnapshot.get('address');
    String description = documentSnapshot.get('description');
    double lat = documentSnapshot.get('lat');
    double lng = documentSnapshot.get('lng');

    return House(
        id: id,
        name: name,
        address: address,
        description: description,
        lat: lat,
        lng: lng
    );
  }
}