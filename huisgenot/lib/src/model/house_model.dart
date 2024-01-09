import 'package:huisgenot/src/model/person_model.dart';

class House {
  final String houseName;
  final String houseAddress;
  final int peopleCount;
  final String biography;
  final List<Person> occupants;

  House({
    required this.houseName,
    required this.houseAddress,
    required this.peopleCount,
    required this.biography,
    required this.occupants,
  });

  factory House.fromMap(Map<String, dynamic> map) {
    return House(
      houseName: map['houseName'],
      houseAddress: map['houseAddress'],
      peopleCount: map['peopleCount'],
      biography: map['biography'],
      occupants: (map['occupants'] as List<dynamic>)
          .map((person) => Person.fromMap(person))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'houseName': houseName,
      'houseAddress': houseAddress,
      'peopleCount': peopleCount,
      'biography': biography,
      'occupants': occupants.map((person) => person.toMap()).toList(),
    };
  }
}
