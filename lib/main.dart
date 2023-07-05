import 'package:flutter/material.dart';
import 'package:flutter_clock/screens/countdown.dart';
import 'package:sizer_pro/sizer.dart';

void main(List<String> args) {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
            theme: ThemeData.dark(
              useMaterial3: true,
            ),
            home: const CountdownScreen() //const StopWatch(),
            );
      },
    );
  }
}
