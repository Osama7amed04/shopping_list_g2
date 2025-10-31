import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF6F6),
      body: Center(
        child: Image.asset(
          'assets/images/watermelonn.gif',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
