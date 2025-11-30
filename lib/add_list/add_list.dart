import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rwad_project/helpers/cubits/cubit/get_users_cubit.dart';
import 'package:rwad_project/screens/search_users_screen.dart';
import 'package:rwad_project/services/fire_store_services.dart';

class AddList extends StatefulWidget {
  final int? updateIndex;
  final Function(String, List<Map<String, dynamic>>)? onListAdded;
  const AddList({super.key, this.updateIndex, this.onListAdded, this.id});
  final String? id;

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  User currentUser = FirebaseAuth.instance.currentUser!;
  List<String> accessedUsers = [];
  final _titleController = TextEditingController();
  final _itemsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> items = [];
  bool isLoading = false;
  Map<String, dynamic>? data;
  loadData() async {
    setState(() {
      isLoading = true;
    });
    data = await FireStoreServices().getList(widget.id!);
    _titleController.text = data!['listName'];
    items = List<String>.from(data!['items']);
    accessedUsers = List<String>.from(data!['accessedUsers']);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    if (widget.id != null) {
      loadData();
    }
    super.initState();
  }
  // int idx = 0;
  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.updateIndex != null) {
  //     idx = widget.updateIndex!;
  //     if (idx < items.length) {
  //       _titleController.text = items[idx]['title'] ?? '';
  //     }
  //   } else {
  //     idx = items.length;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      ////////////////// Title /////////////////////
                      ListTile(
                        leading: IconButton(
                          onPressed: () {
                            // if (_titleController.text.isNotEmpty &&
                            //     widget.onListAdded != null) {
                            //   // حساب كل العناصر في كل categories
                            //   List<Map<String, dynamic>> allItems = [];
                            //   if (idx < items.length && items[idx]['items'] != null) {
                            //     allItems =
                            //         List<Map<String, dynamic>>.from(items[idx]['items']);
                            //   }
                            //   widget.onListAdded!(_titleController.text, allItems);
                            // }
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        title: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'must fill this field';
                            }
                            return null;
                          },
                          controller: _titleController,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                          decoration: InputDecoration(
                            hint: Text(
                              'title',
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey.shade600
                                    : Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            enabledBorder: InputBorder.none,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          // onChanged: (value) {
                          //   setState(() {
                          //     if (value.isNotEmpty && items.length == idx) {
                          //       items.add({'title': value, 'items': []});
                          //     } else if (value.isNotEmpty && items.length > idx) {
                          //       items[idx]['title'] = value;
                          //     }
                          //   });
                          // },
                        ),
                        trailing: InkWell(
                          onTap: () async {
                            final user = await Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => GetusersCubit(),
                                child: SearchUsersScreen(),
                              ),
                            ));
                            if (user != null) {
                              if (!accessedUsers.contains(user)) {
                                accessedUsers.add(user);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    '$user,\nadded to your list',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  backgroundColor: Colors.green,
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    '$user,\nalready added before',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                            log('$accessedUsers');
                          },
                          child: Icon(Icons.person_add_alt_1,
                              color: Theme.of(context).iconTheme.color),
                        ),
                      ),
                      SizedBox(height: 10),
                      ////////////////// Add Items Container /////////////////
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _itemsController,
                              decoration: InputDecoration(
                                fillColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey.shade800
                                    : const Color.fromARGB(255, 226, 225, 225),
                                filled: true,
                                hint: Text(
                                  'Enter Member...',
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey.shade600
                                        : Colors.black54,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.send_rounded,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey.shade600
                                  : Color.fromARGB(255, 201, 199, 199),
                            ),
                            onPressed: () {
                              log(_itemsController.text);
                              setState(() {
                                if (_itemsController.text.isNotEmpty) {
                                  items.add(
                                    _itemsController.text,
                                  );
                                  _itemsController.clear();
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      ////////////////// Assigned To Container /////////////////

                      SizedBox(height: 10),
                      Expanded(
                        child: items.isEmpty
                            ? Center(
                                child: Text(
                                  'No items yet',
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey.shade600
                                        : Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: ListTile(
                                      leading: Text(
                                        "${index + 1}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            items[index],
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.color,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            items.removeAt(index);
                                          });
                                        },
                                        icon: Icon(Icons.close,
                                            color: Colors.red),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (widget.id == null) {
                                FireStoreServices().addListItems(
                                    _titleController.text,
                                    '${currentUser.email}',
                                    items,
                                    accessedUsers);
                                Navigator.of(context).pop();
                              } else {
                                FireStoreServices().updateList(
                                    id: widget.id!,
                                    listName: _titleController.text,
                                    items: items,
                                    accessedUsers: accessedUsers);
                                Navigator.of(context).pop();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              minimumSize: Size(double.infinity, 48)),
                          child: Text(
                              widget.id == null ? 'Add List' : 'Updata List'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
