import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(StopWatchApp());
}
// https://api.dart.dev/stable/2.10.4/dart-async/Timer-class.html
class StopWatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: MainPage()
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Timer _timer;
  var _time = 0;
  List<int> _data = [];
  // FloatingActionButton(
  //   child: Icon(Icons.pause),
  //   onPressed: () {
  //     setState(() {
  //       _timer?.cancel();
  //     });
  //   },
  // ),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STOPWATCH'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$_time'),
            Container(
                height: 300,
                child: ListView(
                  children: _data.map((time) => Text('$time')).toList(),
                )
            ),
            Row(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: RaisedButton(
                      child: Text('초기화'),
                      onPressed: (() {
                        setState(() {
                          setState(() {
                            _data.clear();
                            _timer?.cancel();
                            _time = 0;
                          });
                        });
                      }),
                    ),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FloatingActionButton(
                      child: Icon(Icons.play_arrow),
                      onPressed: () {
                        setState(() {
                          _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
                            setState(() {
                              _time++;
                            });
                          });
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: RaisedButton(
                      child: Text('기록'),
                      onPressed: () {
                        setState(() {
                          _data.insert(0, _time);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}