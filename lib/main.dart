import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rwad_project/screens/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  Future<void> _saveThemePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Login',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF6F6),
        primaryColor: const Color(0xFFFF5A77),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5A77),
          primary: const Color(0xFFFF5A77),
          onPrimary: Colors.white,
          secondary: const Color(0xFFFF5A77),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF5A77),
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFFF5A77),
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1a1a1a),
        primaryColor: const Color(0xFFFF5A77),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0xFFFF5A77),
          primary: const Color(0xFFFF5A77),
          onPrimary: Colors.white,
          secondary: const Color(0xFFFF5A77),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF5A77),
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: false
          ? Test()
          : SplashScreen(onThemeChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
              _saveThemePreference(value);
            }),
    );
  }
}

// شاشة الجيف البطيخة 🍉
class SplashScreen extends StatefulWidget {
  final Function(bool)? onThemeChanged;
  const SplashScreen({super.key, this.onThemeChanged});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                OnBoardingScreen(onThemeChanged: widget.onThemeChanged)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: Center(
        child: Image.asset(
          'assets/images/watermelon.gif',
          width: 250,
          height: 250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
