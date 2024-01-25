import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MgovSignState extends Equatable {
  const MgovSignState();
}

class MgovSignInitial extends MgovSignState {
  @override
  List<Object> get props => [];
}

class MgovSignLoading extends MgovSignState {
  @override
  List<Object> get props => [];
}

class MgovSignSuccess extends MgovSignState {
  // Возможно, вам нужно передать какие-то данные или дополнительные параметры успеха
  @override
  List<Object> get props => [];
}

class MgovSignFailure extends MgovSignState {
  final String error;

  const MgovSignFailure(this.error);

  @override
  List<Object> get props => [error];
}