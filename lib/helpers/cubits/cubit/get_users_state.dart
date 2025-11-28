part of 'get_users_cubit.dart';

@immutable
sealed class GetusersState {}

final class GetusersInitial extends GetusersState {}

final class GetusersLoaded extends GetusersState {
  final List<Map<String, dynamic>> users;

  GetusersLoaded({required this.users});
}

final class GetusersLoading extends GetusersState {}

final class GetusersError extends GetusersState {
  final String error;

  GetusersError({required this.error});
}
