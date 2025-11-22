import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthScreen extends StatelessWidget {
  const FirebaseAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: [
        EmailAuthProvider(),
      ],
      headerBuilder: (context, constraints, _) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              'Sign in',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        );
      },
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            action == AuthAction.signIn
                ? 'Don’t have an account? Register'
                : 'Have an account? Sign in',
            style: const TextStyle(color: Colors.black54),
          ),
        );
      },
      footerBuilder: (context, _) {
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'Forgotten password?',
            style: TextStyle(color: Color(0xFFFF5A77)),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
