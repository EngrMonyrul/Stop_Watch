import 'dart:async';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late DateTime currentTime;
  late DateTime targetTime;
  bool isTimerRunning = false;
  late Timer timer;

  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  void startTimer() {
    if (isTimerRunning) {
      timer.cancel();
    }

    currentTime = DateTime.now();
    final duration = const Duration(days: 3, hours: 0, minutes: 0, seconds: 0);
    targetTime = currentTime.add(duration);

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setTargetTime();
    });

    isTimerRunning = true;
  }

  void setTargetTime() {
    DateTime currentReverseTime = DateTime.now();
    final Duration difference = targetTime.difference(currentReverseTime);

    setState(() {
      days = difference.inDays;
      hours = difference.inHours % 24;
      minutes = difference.inMinutes % 60;
      seconds = difference.inSeconds % 60;
    });
  }

  @override
  void dispose() {
    if (isTimerRunning) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                setWidgetsOfTimes(days, 'Days'),
                setWidgetsOfTimes(hours, 'Hours'),
                setWidgetsOfTimes(minutes, 'Minutes'),
                setWidgetsOfTimes(seconds, 'Seconds'),
              ],
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                startTimer();
              },
              child: const Text('Start Timer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget setWidgetsOfTimes(int time, String unit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black),
          ),
          child: Text(
            '$time',
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          '$unit',
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
