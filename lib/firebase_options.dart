// lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform, kIsWeb;
import 'dart:io' show Platform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    if (Platform.isIOS) {
      return ios;
    } else if (Platform.isAndroid) {
      return android;
    } else if (Platform.isMacOS) {
      return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not configured for this platform.',
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

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyCAY66Crh2YgxOQ1tFjWc5GzlVay_e1XQw",
    authDomain: "sports-app-uae.firebaseapp.com",
    projectId: "sports-app-uae",
    storageBucket: "sports-app-uae.appspot.com",
    messagingSenderId: "926971028793",
    appId: "1:926971028793:ios:f67cb0cf5aff1155af34e8",
    iosBundleId: "com.onebrain.dabbler",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyC9xJvK7M8nQw3R6T5uYzXbWvLpOaV1ErZ",
    authDomain: "sports-app-uae.firebaseapp.com",
    projectId: "sports-app-uae",
    storageBucket: "sports-app-uae.appspot.com",
    messagingSenderId: "926971028793",
    appId: "1:926971028793:android:xyz987uvw654rst321qpo",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyBv6LwZ8Xy4NpT2JhQeRsCmVtUoFgD5Ka",
    authDomain: "sports-app-uae.firebaseapp.com",
    projectId: "sports-app-uae",
    storageBucket: "sports-app-uae.appspot.com",
    messagingSenderId: "926971028793",
    appId: "1:926971028793:macos:lmno456pqrs789tuv123",
  );
}