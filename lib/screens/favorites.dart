import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../add_list/add_list.dart';

class Favorites extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteLists;
  final Function(int) onRemoveFavorite;
  final Function(int, String)? onEditList;
  final Function(String)? onDeleteList; // غير من int لـ String (ID بدل index)
  final Function(int)? onDelete; // callback للحذف من الفيفورت مع التراش

  const Favorites({
    super.key,
    required this.favoriteLists,
    required this.onRemoveFavorite,
    this.onEditList,
    this.onDeleteList,
    this.onDelete,
  });

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        title: Text(
          'Favorite Lists',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
      body: widget.favoriteLists.isEmpty
          ? Center(
              child: Text(
                'No favorite lists yet',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: widget.favoriteLists.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/lists_background.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.favoriteLists[index]['title'] ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      final id =
                                          widget.favoriteLists[index]['id'];
                                      setState(() {
                                        widget.favoriteLists.removeAt(index);
                                      });
                                      widget.onRemoveFavorite(id);
                                    },
                                  ),
                                  PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddList(
                                              updateIndex: index,
                                              onListAdded:
                                                  (listTitle, listItems) {
                                                setState(() {
                                                  widget.favoriteLists[index]
                                                      ['title'] = listTitle;
                                                  widget.favoriteLists[index]
                                                      ['items'] = listItems;
                                                });
                                                // تحديث Home كمان
                                                widget.onEditList
                                                    ?.call(index, listTitle);
                                              },
                                            ),
                                          ),
                                        );
                                      } else if (value == 'delete') {
                                        // استدعي الـ callback للحذف
                                        widget.onDelete?.call(index);
                                        // حدث الصفحة فوراً
                                        setState(() {
                                          if (index <
                                              widget.favoriteLists.length) {
                                            widget.favoriteLists
                                                .removeAt(index);
                                          }
                                        });
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: 'edit',
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 10),
                                            Text('Edit',
                                                style: GoogleFonts.poppins()),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              'Delete',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${widget.favoriteLists[index]['items']?.length ?? 0} items',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Members: 1',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
