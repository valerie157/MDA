import 'package:flutter/material.dart';
import 'package:my_flutter_app/domain/models/services/auth-service.dart';
import 'package:my_flutter_app/models/user_model.dart';
import 'package:my_flutter_app/screens/signin_screens.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;
  String? _errorMessage;
  bool _isLoggedIn = false; // Add a boolean variable to track login status

  UserModel? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn; // Expose the login status

  Future<void> createUserWithEmailAndPassword(
      BuildContext context,
      String firstname,
      String lastname,
      String email,
      String password,
      int mobile) async {
    UserModel? createdUser = await _authService.createUserWithEmailAndPassword(
        context, firstname, lastname, email, password);
    if (createdUser != null) {
      _user = createdUser;
      _errorMessage = null;
      _isLoggedIn = true; // Set isLoggedIn to true after successful sign up
      notifyListeners();
    } else {
      _errorMessage = "An error occurred while creating the user.";
      notifyListeners();
       Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const Login()), // Navigate to the Login screen
    );
    }
  }

  Future<UserModel?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    UserModel? signedInUser =
        await _authService.signInWithEmailAndPassword(context, email, password);
    if (signedInUser != null) {
      _user = signedInUser;
      _errorMessage = null;
      _isLoggedIn = true; // Set isLoggedIn to true after successful sign in
      notifyListeners();
    } else {
      _errorMessage = "Invalid username or Password";
      notifyListeners();
    }
    return signedInUser; // Return the signed in user
  }
}