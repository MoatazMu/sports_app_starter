// lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError(
      'This config only supports Flutter Web for now.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyCAY66Crh2YgxOQ1tFjWc5GzlVay_e1XQw",
    authDomain: "sports-app-uae.firebaseapp.com",
    projectId: "sports-app-uae",
    storageBucket: "sports-app-uae.firebasestorage.app",
    messagingSenderId: "926971028793",
    appId: "1:926971028793:web:d92ca0ae22b22a61af34e8",
  );
}