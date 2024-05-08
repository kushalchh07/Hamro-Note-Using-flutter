import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hamro_note_app/Notes/homepage.dart';
import 'package:hamro_note_app/loginOrsignup/signup.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if user is logged in
          if (snapshot.hasData) {
            return HomePage();
          }
          //if user is not logged in
          else {
            return SignUp();
          }
        },
      ),
    );
  }
}
