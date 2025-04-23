import 'package:blocandprov/Bloc/user/user_event.dart';
import 'package:blocandprov/Bloc/user/user_state.dart';
import 'package:blocandprov/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blocandprov/data/model/userModel.dart';



class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepo;
  UserBloc(this._userRepo) : super(UserInitialState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
     try{
      final  user = await _userRepo.getUsers();
      emit(UserSuccessState(user));
     }catch(e){ 
      emit(UserErrorState(e.toString()));
     }
    
    });
  }
}
