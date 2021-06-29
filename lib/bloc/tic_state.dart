part of 'tic_bloc.dart';

abstract class TicState extends Equatable {
  const TicState();
}

class TicInitial extends TicState {
  @override
  List<Object> get props => [];
}

class TicMoveState extends TicState {
  final Map mapMoveData;
  final String nextMove;
  TicMoveState({required this.mapMoveData, required this.nextMove});
  @override
  List<Object> get props => [mapMoveData, nextMove];
}

class TicWinState extends TicState {
  final Map mapMoveData;
  final List winWay;
  final String winner;
  TicWinState({
    required this.mapMoveData,
    required this.winWay,
    required this.winner,
  });

  @override
  List<Object> get props => [mapMoveData, winWay];
}

class TicCleanState extends TicState {
  @override
  List<Object> get props => [];
}

class TicDrawState extends TicState {
  final Map mapMoveData;
  TicDrawState({required this.mapMoveData});
  @override
  List<Object> get props => [mapMoveData];
}
