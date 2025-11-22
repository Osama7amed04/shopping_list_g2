import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarSelector extends StatefulWidget {
  final String currentAvatar;
  final bool isDark;

  const AvatarSelector({
    super.key,
    required this.currentAvatar,
    required this.isDark,
  });

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  String? selectedAvatar;

  final List<String> avatarList = [
    'assets/images/avatar/boy1.jpg',
    'assets/images/avatar/boy2.jpg',
    'assets/images/avatar/boy3.jpg',
    'assets/images/avatar/boy4.jpg',
    'assets/images/avatar/boy5.jpg',
    'assets/images/avatar/boy6.jpg',
    'assets/images/avatar/girl1.jpg',
    'assets/images/avatar/girl2.jpg',
    'assets/images/avatar/girl3.jpg',
    'assets/images/avatar/girl4.jpg',
    'assets/images/avatar/girl5.jpg',
    'assets/images/avatar/girl6.jpg',
  ];

  @override
  void initState() {
    super.initState();
    selectedAvatar = widget.currentAvatar;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: widget.isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFFF7E5F),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choose Avatar',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // Avatar Horizontal Scroll
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: avatarList.length,
                    itemBuilder: (context, index) {
                      final avatar = avatarList[index];
                      final isSelected = selectedAvatar == avatar;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAvatar = avatar;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFFF7E5F)
                                  : Colors.transparent,
                              width: 4,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFFFF7E5F)
                                          .withOpacity(0.5),
                                      blurRadius: 10,
                                      spreadRadius: 3,
                                    ),
                                  ]
                                : [],
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(avatar),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Select Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, selectedAvatar);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7E5F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Select',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
