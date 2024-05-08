// ignore_for_file: avoid_print, unused_field, use_super_parameters
// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:my_flutter_app/screens/signin_screens.dart'; // Import the SignInScreen

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey, // Change background color
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.0),
                Text('Create an Account', style: TextStyle(color: Colors.white, fontSize: 36.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 20.0),
                Text('Sign up to continue', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                SizedBox(height: 30.0),
                _buildTextField(_usernameController, 'Name', Icons.person),
                SizedBox(height: 10.0),
                _buildTextField(_emailController, 'Email Address', Icons.email),
                SizedBox(height: 20.0),
                _buildTextField(_passwordController, 'Password', Icons.lock, obscureText: true),
                SizedBox(height: 20.0),
                _buildTextField(_passwordController, 'Confirm Password', Icons.lock, obscureText: true),
                SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _signUp(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Sign Up'),
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text('Already have an account? Sign In', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, IconData prefixIcon, {bool obscureText = false}) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(prefixIcon, color: Colors.white), // Add prefix icon
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.white), // Set text color to white
      ),
    );
  }

  void _signUp(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("An error occurred $e");
    }
  }
}
