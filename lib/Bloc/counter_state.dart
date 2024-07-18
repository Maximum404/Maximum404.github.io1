import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';

abstract class CounterState extends Equatable {
  const CounterState();


  @override
  List<Object> get props => [];
}

class InitialCounterState extends CounterState {}

class LoadedCounterState extends CounterState {
  final int count;

  const LoadedCounterState({required this.count});

  @override
  List<Object> get props => [count];
}


