import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String bio;
  final String houseId;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.houseId
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      bio: map['bio'],
      houseId: map['houseId']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'bio': bio,
      'houseId': houseId
    };
  }

  factory User.fromDocument(DocumentSnapshot documentSnapshot) {
    String id = documentSnapshot.id;
    String firstName = documentSnapshot.get('first_name');
    String lastName = documentSnapshot.get('last_name');
    String bio = documentSnapshot.get('last_name');
    String houseId = documentSnapshot.get('house_id');

    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      bio: bio,
      houseId: houseId
    );
  }
}
