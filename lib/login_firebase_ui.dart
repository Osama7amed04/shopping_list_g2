import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/Home.dart';

class LoginFirebaseUi extends StatefulWidget {
  final Function(bool)? onThemeChanged;
  const LoginFirebaseUi({super.key, this.onThemeChanged});

  @override
  State<LoginFirebaseUi> createState() => _LoginFirebaseUiState();
}

class _LoginFirebaseUiState extends State<LoginFirebaseUi> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home(
            isDark: isDarkMode,
            onThemeChanged: (value) async {
              setState(() {
                isDarkMode = value;
              });
              // حفظ الثيم في SharedPreferences
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isDarkMode', value);
              widget.onThemeChanged?.call(value);
            },
            userName: snapshot.data?.displayName ?? 'User',
            userEmail: snapshot.data?.email ?? 'No email',
          );
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
                          builder: (context) => Home(
                                isDark: isDarkMode,
                                onThemeChanged: (value) async {
                                  setState(() {
                                    isDarkMode = value;
                                  });
                                  // حفظ الثيم في SharedPreferences
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool('isDarkMode', value);
                                  widget.onThemeChanged?.call(value);
                                },
                                userName: state.user?.displayName ?? 'User',
                                userEmail: state.user?.email ?? 'No email',
                              )),
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
                      Expanded(
                        child: Text(
                          'Shopping List',
                          style: GoogleFonts.dancingScript(
                            textStyle: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                subtitleBuilder: (context, action) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Welcome to our app',
                    style: TextStyle(color: Colors.grey[700]),
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
