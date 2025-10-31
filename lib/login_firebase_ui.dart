import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFirebaseUi extends StatefulWidget {
  const LoginFirebaseUi({super.key});

  @override
  State<LoginFirebaseUi> createState() => _LoginFirebaseUiState();
}

class _LoginFirebaseUiState extends State<LoginFirebaseUi> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const SuccessScreen();
        }

        return Scaffold(
          body: Center(
            child: SizedBox(
              width: 350,
              child: SignInScreen(
                providers: [
                  EmailAuthProvider(),
                  GoogleProvider(
                    clientId:
                    "497912757265-ahrf7c7btsv7hu6spfki8ngseip1ktn5.apps.googleusercontent.com",
                  ),
                ],
                actions: [
                  AuthStateChangeAction<SignedIn>((context, state) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SuccessScreen()),
                    );
                  }),
                ],
                headerBuilder: (context, constraints, _) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/watermelonn.gif',
                        width: 90,
                        height: 90,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        'Shopping List',
                        style: GoogleFonts.dancingScript(
                          textStyle: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                subtitleBuilder: (context, action) => const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Welcome to our app',
                    style: TextStyle(color: Colors.black54),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginFirebaseUi()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Logged in successfully 🎉",
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5A77),
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginFirebaseUi()),
                );
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
        );
  }
}
