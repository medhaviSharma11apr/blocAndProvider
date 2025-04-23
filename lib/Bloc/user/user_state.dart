import 'package:blocandprov/data/model/userModel.dart';

class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  final User user;

  UserSuccessState(this.user);
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);
}
  