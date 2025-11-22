import 'package:flutter/material.dart';
import 'login_or_register.dart';
import 'on_boarding_list.dart';

class OnBoardingScreen extends StatefulWidget {
  final Function(bool)? onThemeChanged;
  const OnBoardingScreen({super.key, this.onThemeChanged});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 600;

    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: isSmallScreen ? 10.0 : 20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: isSmallScreen ? 20 : 50),
                        // Logo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/watermelon.png',
                              width: screenWidth * 0.08,
                              height: screenWidth * 0.08,
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            Text(
                              'B-List',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: screenWidth * 0.055,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Title
                        Text(
                          '${onBoardingList[index]['title']}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth * 0.065,
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Description
                        SizedBox(
                          width: screenWidth * 0.85,
                          child: Text(
                            '${onBoardingList[index]['description']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey[700],
                              fontStyle: FontStyle.italic,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Image
                        Image.asset(
                          'assets/images/cart6.png',
                          width: screenWidth * 0.6,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        // Dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 4.0,
                          children: [
                            sliderContainer(
                              index == 0
                                  ? const Color(0xffFF7F50)
                                  : const Color.fromARGB(255, 214, 212, 212),
                            ),
                            sliderContainer(
                              index == 1
                                  ? const Color(0xffFF7F50)
                                  : const Color.fromARGB(255, 214, 212, 212),
                            ),
                            sliderContainer(
                              index == 2
                                  ? const Color(0xffFF7F50)
                                  : const Color.fromARGB(255, 214, 212, 212),
                            ),
                            sliderContainer(
                              index == 3
                                  ? const Color(0xffFF7F50)
                                  : const Color.fromARGB(255, 214, 212, 212),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Skip and Next buttons
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: isSmallScreen ? 8.0 : 15.0,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginOrRegister(
                              onThemeChanged: widget.onThemeChanged),
                        ),
                      ),
                      child: Text(
                        index != 3 ? 'Skip' : '',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 5 : 10),
                  ElevatedButton(
                    onPressed: () {
                      if (index == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginOrRegister(),
                          ),
                        );
                      } else {
                        setState(() {
                          index++;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFF7F50),
                      foregroundColor: Colors.white,
                      minimumSize: Size(screenWidth * 0.9, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      index == 3 ? 'Get Started' : 'Next',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget sliderContainer(Color color) {
  return CircleAvatar(radius: 7, backgroundColor: color);
}
