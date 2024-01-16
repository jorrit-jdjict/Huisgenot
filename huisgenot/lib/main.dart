import 'package:flutter/material.dart';
import 'src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Firebase examples
  //var firebase = FirebaseExample();
  //firebase.createRecord();
  //firebase.readData();

  runApp(const HuisGenot());
}
