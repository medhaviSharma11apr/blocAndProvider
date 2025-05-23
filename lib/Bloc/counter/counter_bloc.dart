import 'package:blocandprov/Bloc/counter/counter_event.dart';
import 'package:blocandprov/Bloc/counter/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(count: 0)) {
    on<CounterIncreamentEvent>(
        (event, emit) => emit(CounterState(count: state.count + 1)));

    on<CounterDecrementEvent>(
        (event, emit) => emit(CounterState(count: state.count - 1)));
  }
}
