import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock/screens/countdown.dart';
import 'package:flutter_clock/widgets/clock.dart';
import 'package:sizer_pro/sizer.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  final _stopWatch = Stopwatch();
  final List<Duration> _laps = [];
  final _timeout = const Duration(seconds: 1);

  final ValueNotifier<Duration> _timeNotifier = ValueNotifier(const Duration());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stopwatch",
          style: TextStyle(
            fontSize: 10.f,
            color: Colors.grey,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const CountdownScreen();
                },
              ));
            },
            icon: Icon(
              Icons.timer_outlined,
              size: 12.f,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Clock(
            child: ValueListenableBuilder<Duration>(
              valueListenable: _timeNotifier,
              builder: (BuildContext context, Duration value, Widget? _) {
                return Text(
                  _getDurationText(_stopWatch.elapsed),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.f,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _laps.length,
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lap ${index + 1}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 8.f,
                      ),
                    ),
                    Text(
                      _getDurationText(_laps[index]),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.f,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: _stopWatch.isRunning,
            child: FloatingActionButton(
              heroTag: "addButton",
              onPressed: () {
                _addLap();
              },
              child: Icon(
                Icons.add,
                size: 15.f,
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          FloatingActionButton(
            heroTag: "reset",
            onPressed: _resetButtonPressed,
            child: Icon(
              Icons.refresh_outlined,
              size: 15.f,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          FloatingActionButton(
            heroTag: "playButton",
            onPressed: _startStopButtonPressed,
            child: Icon(
              !_stopWatch.isRunning ? Icons.play_arrow : Icons.pause,
              size: 15.f,
            ),
          ),
        ],
      ),
    );
  }

  void _startStopButtonPressed() {
    setState(() {
      if (_stopWatch.isRunning) {
        _laps.add(_stopWatch.elapsed);
        _stopWatch.stop();
      } else {
        _stopWatch.start();
        _startTimeout();
      }
    });
  }

  void _resetButtonPressed() {
    if (_stopWatch.isRunning) {
      _startStopButtonPressed();
    }
    setState(() {
      _timeNotifier.value = _stopWatch.elapsed;
      _laps.clear();
      _stopWatch.reset();
    });
  }

  void _startTimeout() {
    Timer(_timeout, () {
      _timeNotifier.value = _stopWatch.elapsed;
      if (_stopWatch.isRunning) {
        _startTimeout();
      }
    });
  }

  void _addLap() {
    setState(() {
      _laps.add(_stopWatch.elapsed);
    });
  }

  String _getDurationText(Duration time) {
    return "${time.inHours.toString().padLeft(2, "0")}:${(time.inMinutes % 60).toString().padLeft(2, "0")}:${(time.inSeconds % 60).toString().padLeft(2, "0")}";
  }
}
