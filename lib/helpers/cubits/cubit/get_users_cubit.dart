import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rwad_project/services/fire_store_services.dart';

part 'get_users_state.dart';

class GetusersCubit extends Cubit<GetusersState> {
  GetusersCubit() : super(GetusersInitial());
  getUsers() async {
    emit(GetusersLoading());
    try {
      List<Map<String, dynamic>> users =
          await FireStoreServices().getUsersList();
      emit(GetusersLoaded(users: users));
    } catch (e) {
      emit(GetusersError(error: e.toString()));
    }
  }
}
