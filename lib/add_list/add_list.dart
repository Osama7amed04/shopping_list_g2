import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rwad_project/add_list/listsPage.dart';

class AddList extends StatefulWidget {
  final int? updateIndex;
  const AddList({super.key, this.updateIndex});

  @override
  State<AddList> createState() => _AddListState();
}

List<Map<String, dynamic>> items = [];

class _AddListState extends State<AddList> {
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
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            ////////////////// Title /////////////////////
            ListTile(
              leading: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Listspage()),
                ),
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
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
                decoration: InputDecoration(
                  hint: Text(
                    'title',
                    style: TextStyle(
                      color: Colors.black45,
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
              trailing: Icon(Icons.person_add_alt_1, color: Colors.grey),
            ),
            SizedBox(height: 10),
            ////////////////// Add Items Container /////////////////
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 225, 225),
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
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        enabledBorder: InputBorder.none,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send_rounded,
                    color: const Color.fromARGB(255, 201, 199, 199),
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
            SizedBox(height: 20),
            Expanded(
              child: items.length <= idx || items[idx]['items'].isEmpty
                  ? Center(
                      child: Text(
                        'No items yet',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: items[idx]['items'].length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: IconButton(
                            icon: items[idx]['items'][index]['done']
                                ? Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: Colors.lightGreenAccent,
                                  )
                                : Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                items[idx]['items'][index]['done'] =
                                    !items[idx]['items'][index]['done'];
                              });
                            },
                          ),
                          title: Text(
                            items[idx]['items'][index]['item'],
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                items[idx]['items'].removeAt(index);
                              });
                            },
                            icon: Icon(Icons.close, color: Colors.red),
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
