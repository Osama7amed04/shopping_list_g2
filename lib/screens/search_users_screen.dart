import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rwad_project/helpers/cubits/cubit/get_users_cubit.dart';

class SearchUsersScreen extends StatefulWidget {
  const SearchUsersScreen({super.key});

  @override
  State<SearchUsersScreen> createState() => _SearchUsersScreenState();
}

class _SearchUsersScreenState extends State<SearchUsersScreen> {
  final TextEditingController _itemsController = TextEditingController();
  String search = '';
  @override
  void initState() {
    context.read<GetusersCubit>().getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Member'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      setState(() {
                        search = value;
                      });
                    }
                  });
                },
                controller: _itemsController,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade800
                      : const Color.fromARGB(255, 226, 225, 225),
                  filled: true,
                  suffixIcon: Icon(Icons.search),
                  hint: Text(
                    'Enter Member...',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade600
                          : Colors.black54,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.transparent)),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              Expanded(
                child: BlocBuilder<GetusersCubit, GetusersState>(
                  builder: (context, state) {
                    if (state is GetusersLoaded) {
                      return ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          final user = state.users[index];
                          final email = user['email'] as String;
                          if (search.isNotEmpty) {
                            if (email
                                .toLowerCase()
                                .contains(search.toLowerCase())) {
                              return ListTile(
                                title: Text(email),
                                trailing: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(email);
                                    },
                                    icon: Icon(Icons.add)),
                              );
                            }
                            return SizedBox();
                          } else {
                            return ListTile(
                              title: Text(email),
                              trailing: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(email);
                                  },
                                  icon: Icon(Icons.add)),
                            );
                          }
                        },
                      );
                    } else if (state is GetusersLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Center(child: Text('No data'));
                    }
                  },
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'))
            ],
          ),
        ),
      ),
    );
  }
}
