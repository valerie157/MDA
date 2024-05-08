// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/models/user_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user with email and password
  Future<UserModel?> createUserWithEmailAndPassword(
    BuildContext context,
    String firstname,
    String lastname,
    String email,
    String password,) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;

    //updating the users with additional info in firebase db
    await updateUserProfile(user, firstname, lastname,email);

    return UserModel(
      uid: user?.uid,
      firstname: firstname,
      lastname: lastname,
      email: email,
      name: '',
    );
  } on FirebaseAuthException catch (e) {
    // Handle specific FirebaseAuthException errors
    String errorMessage = '';
    switch (e.code) {
      case 'email-already-in-use':
        errorMessage = 'The account already exists for that email.';
        break;
      default:
        errorMessage = 'An error occurred while creating the user.';
    }
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: errorMessage,
      btnOkOnPress: () {},
    ).show();
    return null;
  }
}

Future<void> updateUserProfile(User? user, String firstname, String lastname,String email) async {
  if (user != null) {
    // using Firebase Firestore to store additional user details
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'firstname': firstname,
        'lastname': lastname,
        'email':email,
      });
    } catch (e) {
      
      print('Error updating user profile: $e');
    }
  }
}
  Future<UserModel?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      return UserModel(uid: user?.uid, name: user?.displayName,email: user?.email, firstname: '', lastname: '');
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException errors
      String errorMessage = '';
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user.';
          break;
        default:
          errorMessage = 'An error occurred while signing in.';
      }

      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: errorMessage,
        btnOkOnPress: () {},
      ).show();
      return null;
}
      }
}