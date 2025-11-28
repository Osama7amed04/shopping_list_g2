import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rwad_project/helpers/cubits/cubit/get_users_cubit.dart';
import 'package:rwad_project/services/fire_store_services.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  User currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetusersCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              StreamBuilder(
                stream: FireStoreServices().getListsSnapshot(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    return Expanded(
                        child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final row = docs[index];
                        final data = row.data() as Map<String, dynamic>;
                        return ListTile(
                          trailing: IconButton(
                              onPressed: () {
                                FireStoreServices().updateList(
                                    row.id,
                                    'Done',
                                    List<String>.from(data['items']),
                                    List<String>.from(data['accessedUsers']));
                              },
                              icon: Icon(Icons.edit)),
                          title: Text('${data['listName']}'),
                          subtitle: Text('${data['items']}'),
                        );
                      },
                    ));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Text('There is error');
                  }
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    FireStoreServices()
                        .addListItems('Tata', currentUser.email!, [
                      'apple',
                      'banana',
                      'watermelon'
                    ], [
                      'a@a.com',
                    ]);
                  },
                  child: Text('Add Data'))
            ],
          ),
        ),
        // body: BlocBuilder<GetusersCubit, GetusersState>(
        //   builder: (context, state) {
        //     if (state is GetusersLoaded) {
        //       return SafeArea(
        //         child: ListView.builder(
        //           itemBuilder: (context, index) {
        //             final user = state.users[index];
        //             return Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //               child: Text(
        //                 user['email'],
        //                 style: TextStyle(fontSize: 24),
        //               ),
        //             );
        //           },
        //           itemCount: state.users.length,
        //         ),
        //       );
        //     } else if (state is GetusersLoading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else {
        //       return Center(
        //         child: ElevatedButton(
        //             onPressed: () {
        //               context.read<GetusersCubit>().getUsers();
        //             },
        //             child: Text('Get Users')),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
