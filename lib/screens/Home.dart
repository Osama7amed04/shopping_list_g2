import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rwad_project/services/fire_store_services.dart';
import 'package:rwad_project/widgets/item_card.dart';
import 'logout.dart';
import 'edit_profile.dart';
import '../add_list/add_list.dart';
import '../utils/user_preferences.dart';

class Home extends StatefulWidget {
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
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> lists = [];
  List<Map<String, dynamic>> trashedLists = [];
  List<Map<String, dynamic>> favoriteLists = [];
  bool showAddForm = false;
  final TextEditingController _titleController = TextEditingController();
  late bool isDarkMode;
  late String currentUserName;
  late String currentUserImage;
  User currentUser = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDark;
    currentUserName = widget.userName;
    currentUserImage = 'assets/images/profileimage1.webp';
    _loadUserData();
  }

  // تحميل البيانات المحفوظة
  Future<void> _loadUserData() async {
    final savedName = await UserPreferences.getUserName();
    final savedImage = await UserPreferences.getUserImage();

    setState(() {
      if (savedName != null && savedName.isNotEmpty) {
        currentUserName = savedName;
      }
      if (savedImage != null && savedImage.isNotEmpty) {
        currentUserImage = savedImage;
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _permanentlyDelete(int index) {
    setState(() {
      trashedLists.removeAt(index);
    });
  }

  void _restoreFromTrash(int index) {
    setState(() {
      final restoredItem = trashedLists[index];
      // ارجعه بدون علامة الفيفورت
      restoredItem['isFavorite'] = false;
      lists.add(restoredItem);
      trashedLists.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        width: MediaQuery.of(context).size.width * 0.7, // 70% من عرض الشاشة
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(
                        isDark: isDarkMode,
                        onThemeChanged: (value) {
                          setState(() {
                            isDarkMode = value;
                          });
                          widget.onThemeChanged(value);
                        },
                        userName: currentUserName,
                        userEmail: widget.userEmail,
                        userImage: currentUserImage,
                      ),
                    ),
                  );

                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      if (result['name'] != null &&
                          result['name'].toString().isNotEmpty) {
                        currentUserName = result['name'];
                      }
                      if (result['image'] != null) {
                        currentUserImage = result['image'];
                      }
                    });
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome,',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                            Text(
                              currentUserName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                            Text(
                              widget.userEmail,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage(currentUserImage),
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
              // ListTile(
              //   leading: Icon(Icons.favorite,
              //       color: Theme.of(context).iconTheme.color),
              //   title: Text('Favorites', style: GoogleFonts.poppins()),
              //   onTap: () {
              //     Navigator.pop(context); // اسحب الـ drawer
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => Favorites(
              //           favoriteLists: favoriteLists,
              //           onRemoveFavorite: (id) {
              //             setState(() {
              //               favoriteLists
              //                   .removeWhere((item) => item['id'] == id);
              //               final index =
              //                   lists.indexWhere((item) => item['id'] == id);
              //               if (index != -1) {
              //                 lists[index]['isFavorite'] = false;
              //               }
              //             });
              //           },
              //           onEditList: (index, newTitle) {
              //             setState(() {
              //               if (index < favoriteLists.length) {
              //                 final id = favoriteLists[index]['id'];
              //                 favoriteLists[index]['title'] = newTitle;
              //                 // حدث في الHome lists كمان
              //                 final homeIndex =
              //                     lists.indexWhere((item) => item['id'] == id);
              //                 if (homeIndex != -1) {
              //                   lists[homeIndex]['title'] = newTitle;
              //                 }
              //               }
              //             });
              //           },
              //           onDeleteList: (listId) {
              //             setState(() {
              //               // ابحث عن الـ list بـ ID في الـ home lists
              //               final homeIndex = lists
              //                   .indexWhere((item) => item['id'] == listId);
              //               if (homeIndex != -1) {
              //                 final deletedItem = lists[homeIndex];
              //                 // اضفها للـ Trash
              //                 trashedLists.add(deletedItem);
              //                 // شيلها من الـ Home
              //                 lists.removeAt(homeIndex);
              //                 // شيلها من الـ Favorites
              //                 favoriteLists.removeWhere(
              //                     (item) => item['id'] == deletedItem['id']);
              //               }
              //             });
              //           },
              //           onDelete: (index) {
              //             // حذف من الفيفورت مع التراش (نفس منطق _moveToTrash)
              //             setState(() {
              //               if (index < favoriteLists.length) {
              //                 final deletedItem = favoriteLists[index];
              //                 // اضفها للـ Trash
              //                 trashedLists.add(deletedItem);
              //                 // شيلها من الـ Favorites
              //                 favoriteLists.removeAt(index);
              //                 // شيلها من الـ Home
              //                 lists.removeWhere(
              //                     (item) => item['id'] == deletedItem['id']);
              //               }
              //             });
              //           },
              //         ),
              //       ),
              //     );
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.delete,
              //       color: Theme.of(context).iconTheme.color),
              //   title: Text('Trash', style: GoogleFonts.poppins()),
              //   onTap: () {
              //     Navigator.pop(context); // اسحب الـ drawer
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => Trash(
              //           trashedLists: trashedLists,
              //           onRestore: _restoreFromTrash,
              //           onPermanentlyDelete: _permanentlyDelete,
              //         ),
              //       ),
              //     );
              //   },
              // ),
              ListTile(
                onTap: () {
                  Navigator.pop(context); // اسحب الـ drawer
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const Logout()));
                },
                leading: Icon(Icons.exit_to_app,
                    color: Theme.of(context).iconTheme.color),
                title: Text('Logout', style: GoogleFonts.poppins()),
              ),
              SwitchListTile(
                title: Text('Dark Mode', style: GoogleFonts.poppins()),
                value: isDarkMode,
                activeColor: Colors.orange[700],
                activeTrackColor: Colors.orange[300],
                inactiveThumbColor: Colors.orange[400],
                inactiveTrackColor: Colors.orange[200],
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                  widget.onThemeChanged(value);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        title: Text(
          'B-List',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),

      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      body: StreamBuilder(
        stream: FireStoreServices().getListsSnapshot(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            if (docs.isNotEmpty) {
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final row = docs[index];
                  final data = row.data() as Map<String, dynamic>;
                  final itemsCount = (data['items'] as List).length;
                  final membersList = data['accessedUsers'] as List;
                  if ((data['creator'] as String) == currentUser.email! ||
                      membersList.contains(currentUser.email!)) {
                    return ItemCard(
                        id: row.id,
                        title: '${data['listName']}',
                        itemsCount: itemsCount,
                        membersCount: membersList.length + 1);
                  } else {
                    return SizedBox();
                  }
                },
              );
            } else {
              return Center(
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
                        '$currentUserName, create your first list in B-list\nIt\'s super simple - press the plus.',
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
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text('There was an error: ${snapshot.error}');
          }
        },
      ),
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddList(
                onListAdded: (listTitle, listItems) {
                  setState(() {
                    lists.add({
                      'id': DateTime.now().millisecondsSinceEpoch,
                      'title': listTitle,
                      'items': listItems,
                      'isFavorite': false,
                      'createdAt': DateTime.now(),
                    });
                  });
                },
              ),
            ),
          );
        },
        backgroundColor: isDarkMode ? Colors.orange[700] : Colors.orange[500],
        child: Icon(Icons.add, color: isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }
}

          ///////////////////////////////////////////////////////////////////////////////////////////////
          // return GestureDetector(
          //   onTap: () {
          //     // Open list details page
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 20.0,
          //       vertical: 12,
          //     ),
          //     child: Container(
          //       padding: const EdgeInsets.all(16.0),
          //       width: double.infinity,
          //       height: 170,
          //       decoration: BoxDecoration(
          //         color: Color(0xff5ac2a0),
          //         borderRadius: BorderRadius.circular(16),
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Flexible(
          //                 child: Text(
          //                   'text',
          //                   maxLines: 1,
          //                   overflow: TextOverflow.ellipsis,
          //                   style: GoogleFonts.poppins(
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.black,
          //                     fontSize: 23,
          //                   ),
          //                 ),
          //               ),
          //               Row(
          //                 children: [
          //                   PopupMenuButton(
          //                     color: Colors.white,
          //                     icon: const Icon(
          //                       Icons.more_vert,
          //                       color: Colors.black,
          //                     ),
          //                     onSelected: (value) {
          //                       if (value == 'edit') {
          //                         Navigator.push(
          //                           context,
          //                           MaterialPageRoute(
          //                             builder: (context) => AddList(
          //                               updateIndex: index,
          //                               onListAdded:
          //                                   (listTitle, listItems) {
          //                                 setState(() {
          //                                   lists[index]['title'] =
          //                                       listTitle;
          //                                   lists[index]['items'] =
          //                                       listItems;
          //                                 });
          //                               },
          //                             ),
          //                           ),
          //                         );
          //                       } else if (value == 'delete') {}
          //                     },
          //                     itemBuilder: (context) => [
          //                       PopupMenuItem(
          //                         value: 'edit',
          //                         child: Row(
          //                           children: [
          //                             const Icon(
          //                               Icons.edit,
          //                               color: Colors.black,
          //                               size: 20,
          //                             ),
          //                             const SizedBox(width: 10),
          //                             Text(
          //                               'Edit',
          //                               style: GoogleFonts.poppins(
          //                                 color: Colors.black,
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                       PopupMenuItem(
          //                         value: 'delete',
          //                         child: Row(
          //                           children: [
          //                             const Icon(
          //                               Icons.delete,
          //                               color: Colors.red,
          //                               size: 20,
          //                             ),
          //                             const SizedBox(width: 10),
          //                             Text(
          //                               'Delete',
          //                               style: TextStyle(
          //                                 color: Colors.red,
          //                                 fontFamily: 'Poppins',
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //           const Spacer(),
          //           Row(
          //             children: [
          //               Container(
          //                 padding: const EdgeInsets.symmetric(
          //                     horizontal: 12, vertical: 6),
          //                 decoration: BoxDecoration(
          //                   color: Colors.orange,
          //                   borderRadius: BorderRadius.circular(20),
          //                 ),
          //                 child: Text(
          //                   '${lists[index]['items']?.length ?? 0} items',
          //                   style: GoogleFonts.poppins(
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 14,
          //                   ),
          //                 ),
          //               ),
          //               const SizedBox(width: 10),
          //               Container(
          //                 padding: const EdgeInsets.symmetric(
          //                     horizontal: 12, vertical: 6),
          //                 decoration: BoxDecoration(
          //                   color: Colors.orange,
          //                   borderRadius: BorderRadius.circular(20),
          //                 ),
          //                 child: Text(
          //                   'Members: 1',
          //                   style: GoogleFonts.poppins(
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 14,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           const SizedBox(height: 10),
          //           SizedBox(
          //             width: double.infinity,
          //             child: Divider(
          //               thickness: 6,
          //               color: Colors.orange,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // );
          ///////////////////////////////////////////////////////////////////////////////////////////////