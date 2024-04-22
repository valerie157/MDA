// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is initialized
  await Firebase.initializeApp( // Initialize Firebase
    options: DefaultFirebaseOptions.currentPlatform, // Use Firebase options from DefaultFirebaseOptions
  );
  runApp(MyApp()); // Run your Flutter app
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Firebase Integration'),
        ),
        // ignore: duplicate_ignore
        // ignore: prefer_const_constructors
        body: Center(
          child: const Text(
            'Firebase Initialized Successfully!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'AIzaSyC-446SVKaslki7sxsciNVZE1CwpmGEcGQ',
      authDomain: 'myflutterap-91522.firebase.com',
      projectId: 'myflutterap-91522', // Replace with your Firebase project ID
      storageBucket: 'myflutterap-91522.appspot.com',
      messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
      appId: 'myflutterap-91522',
    );
  }
}
