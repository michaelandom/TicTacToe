import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/tic_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map data = {};
  List win = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<TicBloc, TicState>(
              builder: (context, state) {
                if (state is TicMoveState) {
                  return Text(
                    "${state.nextMove}'s turn to play",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  );
                } else if (state is TicWinState) {
                  return Text(
                    "${state.winner}'s win the game",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.green.shade200,
                        fontWeight: FontWeight.bold),
                  );
                } else if (state is TicDrawState) {
                  return Text(
                    "the game is draw",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.purple.shade200,
                        fontWeight: FontWeight.bold),
                  );
                }
                return Text(
                  "x starts the game",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 500,
              height: 500,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return BlocBuilder<TicBloc, TicState>(
                      builder: (context, state) {
                        if (state is TicWinState) {
                          print("win win ");
                          data = state.mapMoveData;
                          win = state.winWay;
                          if (data[index] != " ") {
                            return Card(
                              elevation: 2,
                              color: win.contains(index)
                                  ? Colors.green.shade200
                                  : Colors.white54,
                              child: Center(
                                  child: Text(
                                data[index],
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )),
                            );
                          }
                        }
                        if (state is TicMoveState) {
                          data = state.mapMoveData;

                          if (data[index] != " ") {
                            return Card(
                              elevation: 2,
                              color: Colors.white54,
                              child: Center(
                                  child: Text(
                                data[index],
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )),
                            );
                          }
                        } else if (state is TicDrawState) {
                          data = state.mapMoveData;

                          if (data[index] != " ") {
                            return Card(
                              elevation: 2,
                              color: Colors.white54,
                              child: Center(
                                  child: Text(
                                data[index],
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )),
                            );
                          }
                        }
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<TicBloc>(context)
                                .add(TicMoveEvent(index: index));
                          },
                          child: Card(
                            elevation: 5,
                            color: Colors.black54,
                            child: Text(" "),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<TicBloc>(context).add(TicCleanEvent());
        },
        tooltip: 'clean',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
