import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tic_event.dart';
part 'tic_state.dart';

class TicBloc extends Bloc<TicEvent, TicState> {
  String moveData = "x";
  List<int> xList = [];
  List<int> oList = [];
  Map mapData = {
    0: " ",
    1: " ",
    2: " ",
    3: " ",
    4: " ",
    5: " ",
    6: " ",
    7: " ",
    8: " ",
  };
  TicBloc() : super(TicInitial());
  Future<List?> checkFun(List x) async {
    if (x.contains(2) && x.contains(1) && x.contains(0))
      return [2, 1, 0];
    else if (x.contains(0) && x.contains(4) && x.contains(8))
      return [0, 4, 8];
    else if (x.contains(0) && x.contains(3) && x.contains(6))
      return [6, 3, 0];
    else if (x.contains(1) && x.contains(4) && x.contains(7))
      return [4, 1, 7];
    else if (x.contains(2) && x.contains(4) && x.contains(6))
      return [2, 4, 6];
    else if (x.contains(3) && x.contains(4) && x.contains(5))
      return [3, 4, 5];
    else if (x.contains(6) && x.contains(7) && x.contains(8))
      return [6, 7, 8];
    else
      return [];
  }

  Future<bool?> checkDraw() async {
    if (xList.length == 5 && oList.length == 4 ||
        oList.length == 5 && xList.length == 4) {
      return true;
    }
    return false;
  }

  @override
  Stream<TicState> mapEventToState(
    TicEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is TicMoveEvent) {
      mapData[event.index] = moveData;
      yield TicInitial();
      yield TicMoveState(
          mapMoveData: mapData, nextMove: moveData == "x" ? "o" : "x");
      if (moveData == "x") {
        moveData = "o";
        print(moveData);
        xList.add(event.index);
        final result = await checkFun(xList) as List;
        if (result.length > 0) {
          yield TicWinState(mapMoveData: mapData, winWay: result, winner: "x");
        } else {
          final resultDraw = await checkDraw() as bool;
          if (resultDraw) {
            yield TicDrawState(mapMoveData: mapData);
          }
        }
      } else {
        moveData = "x";
        oList.add(event.index);
        final result = await checkFun(oList) as List;
        if (result.length > 0) {
          yield TicWinState(mapMoveData: mapData, winWay: result, winner: "o");
        } else {
          final resultDraw = await checkDraw() as bool;
          if (resultDraw) {
            yield TicDrawState(mapMoveData: mapData);
          }
        }
      }
    }
    if (event is TicCleanEvent) {
      yield TicInitial();
      moveData = "x";
      oList = [];
      xList = [];
      mapData = {
        0: " ",
        1: " ",
        2: " ",
        3: " ",
        4: " ",
        5: " ",
        6: " ",
        7: " ",
        8: " ",
      };
      yield TicCleanState();
    }
  }
}
