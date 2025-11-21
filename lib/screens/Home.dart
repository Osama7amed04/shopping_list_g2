import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/CustomAddButton.dart';
import 'logout.dart';
import 'list.dart';
import 'edit_profile.dart';

class Home extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final String userName;
  final String userEmail;

  const Home({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(
                      isDark: isDark,
                      onThemeChanged: onThemeChanged,
                      userName: userName,
                      userEmail: userEmail,
                      userImage: 'assets/images/profileimage1.webp',
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Welcome, $userName!',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: const AssetImage('assets/images/profileimage1.webp'),
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),

            ListTile(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (c) => Listspage())),
              leading: Icon(Icons.library_books_sharp,
                  color: Theme.of(context).iconTheme.color),
              title: Text('Lists', style: GoogleFonts.poppins()),
            ),
            ListTile(
              leading:
              Icon(Icons.delete, color: Theme.of(context).iconTheme.color),
              title: Text('Trash', style: GoogleFonts.poppins()),
            ),
            ListTile(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (c) => const Logout())),
              leading:
              Icon(Icons.exit_to_app, color: Theme.of(context).iconTheme.color),
              title: Text('Logout', style: GoogleFonts.poppins()),
            ),
            SwitchListTile(
              title: Text('Dark Mode', style: GoogleFonts.poppins()),
              value: isDark,
              onChanged: onThemeChanged,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/projectEcommerce.png',
                    width: screenWidth * 0.6,
                  ),
                  const SizedBox(height: 28),
                  Text(
                    '$userName, create your first list in B-list\nIt\'s super simple - press the plus.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.05,
            left: 0,
            right: 0,
            child: Center(
              child: InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (c) => Listspage())),
                child: const CustomAddButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

