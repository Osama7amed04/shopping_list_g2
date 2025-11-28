import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rwad_project/helpers/cubits/cubit/get_users_cubit.dart';
import 'package:rwad_project/screens/search_users_screen.dart';

class AddList extends StatefulWidget {
  final int? updateIndex;
  final Function(String, List<Map<String, dynamic>>)? onListAdded;
  const AddList({super.key, this.updateIndex, this.onListAdded});

  @override
  State<AddList> createState() => _AddListState();
}

List<Map<String, dynamic>> items = [];

class _AddListState extends State<AddList> {
  List<String> accessedUsers = [];
  final _titleController = TextEditingController();
  final _itemsController = TextEditingController();
  int idx = 0;

  @override
  void initState() {
    super.initState();
    if (widget.updateIndex != null) {
      idx = widget.updateIndex!;
      if (idx < items.length) {
        _titleController.text = items[idx]['title'] ?? '';
      }
    } else {
      idx = items.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            ////////////////// Title /////////////////////
            ListTile(
              leading: IconButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      widget.onListAdded != null) {
                    // حساب كل العناصر في كل categories
                    List<Map<String, dynamic>> allItems = [];
                    if (idx < items.length && items[idx]['items'] != null) {
                      allItems =
                          List<Map<String, dynamic>>.from(items[idx]['items']);
                    }
                    widget.onListAdded!(_titleController.text, allItems);
                  }
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              title: TextField(
                controller: _titleController,
                autofocus: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
                decoration: InputDecoration(
                  hint: Text(
                    'title',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade600
                          : Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty && items.length == idx) {
                      items.add({'title': value, 'items': []});
                    } else if (value.isNotEmpty && items.length > idx) {
                      items[idx]['title'] = value;
                    }
                  });
                },
              ),
              trailing: InkWell(
                onTap: () async {
                  final user =
                      await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => GetusersCubit(),
                      child: SearchUsersScreen(),
                    ),
                  ));
                  accessedUsers.contains(user) ? null : accessedUsers.add(user);
                  log('$accessedUsers');
                },
                child: Icon(Icons.person_add_alt_1,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
            SizedBox(height: 10),
            ////////////////// Add Items Container /////////////////
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade800
                          : const Color.fromARGB(255, 226, 225, 225),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: _itemsController,
                        decoration: InputDecoration(
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Enter item...',
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey.shade600
                                    : Colors.black54,
                              ),
                            ),
                          ),
                          enabledBorder: InputBorder.none,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send_rounded,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade600
                        : Color.fromARGB(255, 201, 199, 199),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_itemsController.text.isNotEmpty &&
                          items.length > idx) {
                        items[idx]['items'].add({
                          'item': _itemsController.text,
                          'done': false,
                        });
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
              child: items.length <= idx || items[idx]['items'].isEmpty
                  ? Center(
                      child: Text(
                        'No items yet',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade600
                              : Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: items[idx]['items'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: ListTile(
                            leading: IconButton(
                              icon: items[idx]['items'][index]['done']
                                  ? Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: Colors.lightGreenAccent,
                                    )
                                  : Icon(
                                      Icons.add_circle_outline,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                              onPressed: () {
                                setState(() {
                                  items[idx]['items'][index]['done'] =
                                      !items[idx]['items'][index]['done'];
                                });
                              },
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[idx]['items'][index]['item'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Assigned to: ${items[idx]['items'][index]['assignedTo'] ?? 'All Members'}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey.shade600
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  items[idx]['items'].removeAt(index);
                                });
                              },
                              icon: Icon(Icons.close, color: Colors.red),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
