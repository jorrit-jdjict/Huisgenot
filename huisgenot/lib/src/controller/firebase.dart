import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';


class FirebaseExample {
  var databaseURL = 'https://huisgenot-fba16-default-rtdb.europe-west1.firebasedatabase.app/';
  void createRecord() {
    // Database test

    /*
    DatabaseReference databaseReference = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: databaseURL
    ).ref();

    databaseReference.child('users').push().set({
      'name': 'test',
      'email': 'johndoe@example.com',
      'age': 24,
    });
  }
  Future<void> readData() async {
    var snapshot = await FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: databaseURL
    ).ref('users').get();

    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      print(value);
    });
  */
  }
}


