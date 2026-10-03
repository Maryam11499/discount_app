// File: lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDkgy0tWTX3DDQDn6u2tkBYPIAZosjRKjE',
    appId: '1:478347064101:web:450bb6ede833807e2220cc',
    messagingSenderId: '478347064101',
    projectId: 'dhimis-app-2026',
    authDomain: 'dhimis-app-2026.firebaseapp.com',
    storageBucket: 'dhimis-app-2026.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkgy0tWTX3DDQDn6u2tkBYPIAZosjRKjE',
    appId: '1:478347064101:android:9ec226b04bc1d87e2220cc',
    messagingSenderId: '478347064101',
    projectId: 'dhimis-app-2026',
    storageBucket: 'dhimis-app-2026.appspot.com',
  );
}