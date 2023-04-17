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
        return macos;
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
    apiKey: 'AIzaSyDCcUguHOyIxl7zUXaXF4q8RZgCQtfvClE',
    appId: '1:815170067345:web:dbf591ace61fc3a421d830',
    messagingSenderId: '815170067345',
    projectId: 'elmazon',
    authDomain: 'elmazon.firebaseapp.com',
    storageBucket: 'elmazon.appspot.com',
    measurementId: 'G-QDHYNTH50Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsewnFrvnkbaQ00Zxxn6130560Aj28-jE',
    appId: '1:815170067345:android:33656b2c9e010e3b21d830',
    messagingSenderId: '815170067345',
    projectId: 'elmazon',
    storageBucket: 'elmazon.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzTRaq7SoJ8MTLa3Upxnu8f4Cn0CDAxcc',
    appId: '1:815170067345:ios:fe693df1405b826221d830',
    messagingSenderId: '815170067345',
    projectId: 'elmazon',
    storageBucket: 'elmazon.appspot.com',
    iosClientId: '815170067345-p03cdoe09s7b143hn5dejenamj4cgbo2.apps.googleusercontent.com',
    iosBundleId: 'com.topbusiness.newMazoon',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAzTRaq7SoJ8MTLa3Upxnu8f4Cn0CDAxcc',
    appId: '1:815170067345:ios:fe693df1405b826221d830',
    messagingSenderId: '815170067345',
    projectId: 'elmazon',
    storageBucket: 'elmazon.appspot.com',
    iosClientId: '815170067345-p03cdoe09s7b143hn5dejenamj4cgbo2.apps.googleusercontent.com',
    iosBundleId: 'com.topbusiness.newMazoon',
  );
}
