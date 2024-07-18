import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(InitialCounterState());

  int _count = 0;

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is IncrementCounter) {
      _count++;
      yield LoadedCounterState(count: _count);
    } else if (event is ResetCounter) {
      _count = 0;
      yield LoadedCounterState(count: _count);
    }
  }
}
