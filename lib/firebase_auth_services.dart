

// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signUp(String email, String password) async{
    try{
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      print('Sign Up successful');
      return _auth.currentUser;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (e) {
    print(e.toString());
    // Handle error
  }
}
}

