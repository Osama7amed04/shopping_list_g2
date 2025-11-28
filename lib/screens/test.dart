import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rwad_project/helpers/cubits/cubit/get_users_cubit.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetusersCubit(),
      child: Scaffold(
        body: BlocBuilder<GetusersCubit, GetusersState>(
          builder: (context, state) {
            if (state is GetusersLoaded) {
              return SafeArea(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        user['email'],
                        style: TextStyle(fontSize: 24),
                      ),
                    );
                  },
                  itemCount: state.users.length,
                ),
              );
            } else if (state is GetusersLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: ElevatedButton(
                    onPressed: () {
                      context.read<GetusersCubit>().getUsers();
                    },
                    child: Text('Get Users')),
              );
            }
          },
        ),
      ),
    );
  }
}
