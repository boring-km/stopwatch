import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(StopWatchApp());
}

// https://api.dart.dev/stable/2.10.4/dart-async/Timer-class.html
class StopWatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Timer _timer;
  var _ms = 0;
  var _sec = 0;
  List<String> _data = [];
  var _onOff = false;
  var _play = Icon(Icons.play_arrow);
  var _rank = 0;

  var _playColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STOPWATCH'),
      ),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '$_sec',
                            style: TextStyle(fontSize: 40),
                          ),
                          Text('$_ms'),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 400,
                          child: ListView(
                            children: _data.map((time) => Text(
                              time,
                              textAlign: TextAlign.center,
                            )).toList(),
                          )
                        ),
                      ),
                    ],
                  ),

                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        buildResetButton(),
                        buildPlayButton(),
                        buildRecordButton(),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }

  RaisedButton buildRecordButton() {
    return RaisedButton(
      child: Text('랩타임'),
      onPressed: () {
        setState(() {
          _rank++;
          _data.insert(0, '$_rank등 $_sec.$_ms');
        });
      },
    );
  }

  FloatingActionButton buildPlayButton() {
    return FloatingActionButton(
      child: _play,
      backgroundColor: _playColor,
      onPressed: () {
        setState(() {
          if (!_onOff) {
            _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
              setState(() {
                _onOff = true;
                _play = Icon(Icons.pause);
                _playColor = Colors.green;
                _ms++;
                if (_ms == 100) {
                  _sec++;
                  _ms = 0;
                }
              });
            });
          } else {
            setState(() {
              _onOff = false;
              _play = Icon(Icons.play_arrow);
              _playColor = Colors.blue;
              _timer.cancel();
            });
          }
        });
      },
    );
  }

  FloatingActionButton buildResetButton() {
    return FloatingActionButton(
      child: Icon(Icons.update_rounded),
      backgroundColor: Colors.pink,
      onPressed: () {
        setState(() {
          _data.clear();
          _rank = 0;
          _ms = 0;
          _sec = 0;
        });
      },
    );
  }
}
