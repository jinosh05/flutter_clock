import 'package:flutter/material.dart';
import 'package:flutter_clock/widgets/clock.dart';
import 'package:flutter_clock/widgets/timer_controller.dart';
import 'package:flutter_clock/widgets/timer_count_down.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:sizer_pro/sizer.dart';

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({super.key});

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  // Controller
  final CountdownController _controller = CountdownController(autoStart: false);
  Duration duration = const Duration();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Countdown",
          style: TextStyle(
            fontSize: 10.f,
            color: Colors.grey,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Clock(
            child: Countdown(
              controller: _controller,
              seconds: duration.inSeconds,
              build: (_, double time) => Text(
                _getDurationText(
                  Duration(
                    seconds: time.toInt(),
                  ),
                ),
                style: TextStyle(
                  fontSize: 12.f,
                ),
              ),
              interval: const Duration(milliseconds: 100),
              onFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Timer is done!'),
                  ),
                );
              },
            ),
          ),
          const Row(
            children: [],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "playButton",
        onPressed: () {
          _getDuration(context).showDialog(context);
        },
        child: Icon(
          Icons.play_arrow,
          size: 15.f,
        ),
      ),
    );
  }

  Picker _getDuration(BuildContext context) {
    return Picker(
      textStyle: TextStyle(color: Colors.white, fontSize: 9.f),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      adapter: NumberPickerAdapter(
        data: <NumberPickerColumn>[
          const NumberPickerColumn(begin: 0, end: 24, suffix: Text(' H')),
          const NumberPickerColumn(
            begin: 0,
            end: 60,
            suffix: Text(' M'),
          ),
          const NumberPickerColumn(
              begin: 0, end: 60, suffix: Text(' S'), jump: 5),
        ],
      ),
      delimiter: <PickerDelimiter>[
        PickerDelimiter(
          child: Container(
            width: 12.f,
            alignment: Alignment.center,
            child: Icon(
              Icons.more_vert,
              size: 9.f,
            ),
          ),
        ),
      ],
      hideHeader: true,
      confirmText: 'OK',
      confirmTextStyle: TextStyle(
          color: Colors.blue, fontSize: 12.f, fontWeight: FontWeight.bold),
      title: Text(
        'Select duration',
        style: TextStyle(
            color: Colors.white, fontSize: 12.f, fontWeight: FontWeight.bold),
      ),
      selectedTextStyle: const TextStyle(color: Colors.blue),
      onConfirm: (Picker picker, List<int> value) {
        setState(() {
          duration = Duration(
            hours: picker.getSelectedValues()[0],
            minutes: picker.getSelectedValues()[1],
            seconds: picker.getSelectedValues()[2],
          );
        });
      },
    );
  }

  String _getDurationText(Duration time) {
    return "${time.inHours.toString().padLeft(2, "0")}:${(time.inMinutes % 60).toString().padLeft(2, "0")}:${(time.inSeconds % 60).toString().padLeft(2, "0")}";
  }
}
