class Person {
  final String name;
  final int age;
  final List<String> interests;

  Person({
    required this.name,
    required this.age,
    required this.interests,
  });

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      name: map['name'],
      age: map['age'],
      interests:
          (map['interests'] as List<dynamic>).map((i) => i.toString()).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'interests': interests,
    };
  }
}
