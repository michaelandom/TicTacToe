part of 'tic_bloc.dart';

abstract class TicEvent extends Equatable {
  const TicEvent();
}

class TicMoveEvent extends TicEvent {
  final int index;

  TicMoveEvent({required this.index});
  @override
  List<Object> get props => [index];
}

class TicCleanEvent extends TicEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
