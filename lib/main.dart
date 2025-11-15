// import 'package:flutter/material.dart';
// import 'package:rwad_project/add_list/add_list.dart';
// import 'package:rwad_project/add_list/listsPage.dart';
// import 'package:rwad_project/on_boarding/on_boarding_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Shopping List App',
//       home: const Listspage(),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_firebase_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Login',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF6F6), // خلفية وردية فاتحة
        primaryColor: const Color(0xFFFF5A77), // لون البطيخة
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5A77),
          primary: const Color(0xFFFF5A77),
          onPrimary: Colors.white, // الكلام الأبيض داخل الزرار
          secondary: const Color(0xFFFF5A77),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF5A77), // لون الزرار بطيخي
            foregroundColor: Colors.white, // الكلام أبيض
            shadowColor: Colors.transparent, // بدون ظل غامق
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
            foregroundColor: const Color(0xFFFF5A77), // نصوص مثل register
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// شاشة الجيف البطيخة 🍉
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
        MaterialPageRoute(builder: (context) => const LoginFirebaseUi()),
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