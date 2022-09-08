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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXTcm9E5K-jA8cirzRPLIWHtLasxCUDBM',
    appId: '1:829924956073:android:116d03e75887089d6056b8',
    messagingSenderId: '829924956073',
    projectId: 'herfaty-54792',
    databaseURL: 'https://herfaty-54792-default-rtdb.firebaseio.com',
    storageBucket: 'herfaty-54792.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDspWgDKdmrZAQbMNJkjkdXTNZLApN4nUg',
    appId: '1:829924956073:ios:723b6aab1c49b2d16056b8',
    messagingSenderId: '829924956073',
    projectId: 'herfaty-54792',
    databaseURL: 'https://herfaty-54792-default-rtdb.firebaseio.com',
    storageBucket: 'herfaty-54792.appspot.com',
    iosClientId: '829924956073-3orfga3eg1nlcjv21fsdn4uhf4v4if2m.apps.googleusercontent.com',
    iosBundleId: 'com.example.herfaty',
  );
}
