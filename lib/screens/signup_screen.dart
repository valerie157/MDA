// ignore_for_file: avoid_print, unused_field, use_super_parameters
// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/firebase_auth_services.dart';
import 'package:my_flutter_app/form_container_widget.dart';
// ignore: unused_import
import 'package:my_flutter_app/screens/signin_screens.dart'; // Import the SignInScreen

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();

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
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.brown, // Set the background color here
        ),
        
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.0),
                  Text('Create an Account', style: TextStyle(color: Colors.white, fontSize: 36.0, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20.0),
                  Text('Sign up to continue', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                  SizedBox(height: 30.0),

                  
                  FormContainerWidget(
                    controller: _usernameController,
                    children: [
                      InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // Make the text field rounded
                            borderSide: BorderSide.none,
                          ),
                        ),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Icon(Icons.person, color: Colors.white, size: 24.0,),
                            SizedBox(width: 10.0),
                            Expanded(child: TextField()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  
                  FormContainerWidget(
                    controller: _emailController,
                    children: [
                      InputDecorator(
                        decoration: InputDecoration(
                        
                          labelText: 'Email Address',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // Make the text field rounded
                            borderSide: BorderSide.none,
                          ),
                        ),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Icon(Icons.email, color: Colors.white, size: 24.0,),
                            SizedBox(width: 10.0),
                            Expanded(child: TextField()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  FormContainerWidget(
                    controller: _passwordController,
                    children: [
                      InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // Make the text field rounded
                            borderSide: BorderSide.none,
                          ),
                        ),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Icon(Icons.lock, color: Colors.white, size: 24.0,),
                            SizedBox(width: 10.0),
                            Expanded(child: TextField(obscureText: true)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Make the text field rounded
                        borderSide: BorderSide.none,
                      ),
                    ),
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Icon(Icons.lock, color: Colors.white, size: 24.0,),
                        SizedBox(width: 10.0),
                        Expanded(child: TextField(obscureText: true)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _signUp(context);
                      },
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.white,
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
                          MaterialPageRoute(builder: (context) => SignUpScreen()), // Navigate to the SignInScreen
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

  void _signUp(BuildContext context) async {
    String  email = _emailController.text;
    String password = _passwordController.text;


    try{
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    }catch (e) {
      print("An error occured $e");
    }
  }
}
