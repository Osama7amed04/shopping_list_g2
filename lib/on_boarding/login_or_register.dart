import 'package:flutter/material.dart';
import 'package:rwad_project/login_firebase_ui.dart';

class LoginOrRegister extends StatelessWidget {
  const LoginOrRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
        child: Column(
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
            SizedBox(height: 70),
            Image.asset('assets/images/cart9.png'),
            SizedBox(height: 150),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Color(0xffFF7F50),
            //     foregroundColor: Colors.white,
            //     minimumSize: Size(350, 50),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //   ),
            //   child: Text(
            //     'Sign In',
            //     style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
            //   ),
            // ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginFirebaseUi()),
                );
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
                'Get Started',
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
