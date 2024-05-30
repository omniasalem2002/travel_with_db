import 'package:guru/Screens/register/models/AddUserResponse.dart';

abstract class AddUserState {}

class AddUserInitial extends AddUserState {}

class AddUserLoading extends AddUserState {}

class AddUserFailure extends AddUserState {
  final String error;

  AddUserFailure({required this.error});
}

class AddUserSuccess extends AddUserState {
  final AddUserResponse response;

  AddUserSuccess({
    required this.response,
  });
}
