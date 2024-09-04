// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<CounterIncrementEvent>(counterIncrementEvent);
    on<CounterShowSnackBarEvent>(counterShowSnackBarEvent);
  }

  int value = 0;

  FutureOr<void> counterIncrementEvent(CounterIncrementEvent event, Emitter<CounterState> emit) {
    value += 1;
    emit(CounterIncrementState(val: value));
    // emit(CounterIncrementActionState());
  }

  FutureOr<void> counterShowSnackBarEvent(CounterShowSnackBarEvent event, Emitter<CounterState> emit) {
    emit(CounterShowSnacbarActionState());
    
  }
}
