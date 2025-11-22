import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home.dart';

class Success extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final String userName;
  final String userEmail;

  const Success({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/waterma2.png',
                      width: screenWidth * 0.08,
                      height: screenWidth * 0.08,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'B-List',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Text(
                  '$userName, you are successfully\nlogged into the app.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 35),
                Image.asset(
                  'assets/images/ecomercephoto2.png',
                  width: screenWidth * 0.7,
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: screenWidth * 0.8,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7E5F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => Home(
                            isDark: isDark,
                            onThemeChanged: onThemeChanged,
                            userName: userName,
                            userEmail: userEmail,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Get started',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
