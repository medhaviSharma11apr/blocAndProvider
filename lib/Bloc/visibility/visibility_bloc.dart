import 'package:blocandprov/Bloc/visibility/visibility_evebt.dart';
import 'package:blocandprov/Bloc/visibility/visibility_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  VisibilityBloc() : super(VisibilityState(show: true)) {
    on<VisibilityTrue>((event, emit) => emit(VisibilityState(show: true)));
    on<VisibilityFalse>((event, emit) => emit(VisibilityState(show: false)));
  }
}
