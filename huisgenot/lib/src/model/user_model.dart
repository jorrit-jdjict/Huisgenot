import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String first_name;
  final String last_name;
  final String bio;
  final String house_id;

  User(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.bio,
      required this.house_id});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'],
        first_name: map['first_name'],
        last_name: map['last_name'],
        bio: map['bio'],
        house_id: map['house_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'bio': bio,
      'house_id': house_id
    };
  }

  factory User.fromDocument(DocumentSnapshot documentSnapshot) {
    String id = documentSnapshot.id;
    String first_name = documentSnapshot.get('first_name');
    String last_name = documentSnapshot.get('last_name');
    String bio = documentSnapshot.get('bio');
    String house_id = documentSnapshot.get('house_id');

    return User(
        id: id,
        first_name: first_name,
        last_name: last_name,
        bio: bio,
        house_id: house_id);
  }
}
