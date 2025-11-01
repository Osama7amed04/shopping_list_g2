import 'package:flutter/material.dart';
import 'login_or_register.dart';
import 'on_boarding_list.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/watermelon.png',
                    width: 35,
                    height: 35,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'B-List',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                '${on_boarding_list[index]['title']}',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: Text(
                  '${on_boarding_list[index]['description']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Image.asset('assets/images/cart6.png'),
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4.0,
                children: [
                  sliderContainer(
                    index == 0
                        ? Color(0xffFF7F50)
                        : const Color.fromARGB(255, 214, 212, 212),
                  ),
                  sliderContainer(
                    index == 1
                        ? Color(0xffFF7F50)
                        : const Color.fromARGB(255, 214, 212, 212),
                  ),
                  sliderContainer(
                    index == 2
                        ? Color(0xffFF7F50)
                        : const Color.fromARGB(255, 214, 212, 212),
                  ),
                  sliderContainer(
                    index == 3
                        ? Color(0xffFF7F50)
                        : const Color.fromARGB(255, 214, 212, 212),
                  ),
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginOrRegister()),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      index != 3 ? 'Skip' : '',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (index == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginOrRegister(),
                      ),
                    );
                  } else {
                    setState(() {
                      index++;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFF7F50),
                  foregroundColor: Colors.white,
                  minimumSize: Size(350, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget sliderContainer(Color color) {
  return CircleAvatar(radius: 7, backgroundColor: color);
}
