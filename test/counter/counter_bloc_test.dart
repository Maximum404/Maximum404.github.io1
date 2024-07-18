import 'package:bloc_test/bloc_test.dart';
import 'package:cash_coin/Bloc/counter_bloc.dart';
import 'package:cash_coin/Bloc/counter_event.dart';
import 'package:cash_coin/Bloc/counter_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


void main() {
  group('CounterBloc', () {
    late CounterBloc counterBloc;

    setUp(() {
      counterBloc = CounterBloc();
    });

    tearDown(() {
      counterBloc.close();
    });

    test('initial state is InitialCounterState', () {
      expect(counterBloc.state, equals(InitialCounterState()));
    });

    blocTest<CounterBloc, CounterState>(
      'emits LoadedCounterState with incremented count when IncrementCounter event is added',
      build: () => counterBloc,
      act: (bloc) => bloc.add(IncrementCounter()),
      expect: () => [LoadedCounterState(count: 1)],
    );

    blocTest<CounterBloc, CounterState>(
      'emits LoadedCounterState with reset count when ResetCounter event is added',
      build: () {
        counterBloc = CounterBloc();
        counterBloc.add(IncrementCounter());
        counterBloc.add(IncrementCounter());
        counterBloc.add(ResetCounter()); // Сбросить счётчик перед тестом
        return counterBloc;
      },
      act: (bloc) {
        bloc.add(ResetCounter());
      },
      expect: () => [LoadedCounterState(count: 0)],
    );


  });
}
