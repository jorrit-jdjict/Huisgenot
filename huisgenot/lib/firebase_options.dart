// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBOkAw0sgdbgG4RDqYoLZnOFkCR4fx3iCk',
    appId: '1:33662473182:web:f09e8a70917694c0c0c34f',
    messagingSenderId: '33662473182',
    projectId: 'huisgenot-fba16',
    authDomain: 'huisgenot-fba16.firebaseapp.com',
    storageBucket: 'huisgenot-fba16.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuX_rXk6I-1WTBzjQfP95Z1GF0YCk8sUU',
    appId: '1:33662473182:android:163fb22a724b5a9ac0c34f',
    messagingSenderId: '33662473182',
    projectId: 'huisgenot-fba16',
    storageBucket: 'huisgenot-fba16.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKLPOw-rT9aP5H77qbghbP-xm2hFffe3Y',
    appId: '1:33662473182:ios:2c2f58d1b0d7a656c0c34f',
    messagingSenderId: '33662473182',
    projectId: 'huisgenot-fba16',
    storageBucket: 'huisgenot-fba16.appspot.com',
    iosBundleId: 'com.example.huisgenot',
  );
}