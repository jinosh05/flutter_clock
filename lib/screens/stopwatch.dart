import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  final _stopWatch = Stopwatch();
  final List<Duration> _laps = [
    const Duration(minutes: 2, seconds: 25),
  ];
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
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 35.w,
              height: 35.w,
              margin: EdgeInsets.symmetric(vertical: 5.h),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    offset: const Offset(-6.0, -6.0),
                    blurRadius: 8.sp,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(6.0, 6.0),
                    blurRadius: 8.sp,
                  ),
                ],
                color: const Color(0xFF292D32),
              ),
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
                      _setStopwatchText(_laps[index]),
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
    );
  }

  String _setStopwatchText(Duration time) {
    return "${time.inHours.toString().padLeft(2, "0")}:${(time.inMinutes % 60).toString().padLeft(2, "0")}:${(time.inSeconds % 60).toString().padLeft(2, "0")}";
  }
}
