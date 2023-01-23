import 'package:flutter/material.dart';
import 'package:flutter_timer/timer_controller.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final TimerController timerController = TimerController();

  @override
  void initState() {
    timerController.addListener(_listenTimer);
    super.initState();
  }

  @override
  void dispose() {
    timerController.removeListener(_listenTimer);
    timerController.dispose();
    super.dispose();
  }

  _listenTimer() {
    if(!mounted) {
      return;
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timer Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              timerController.currentTimeInSeconds.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: timerController.isActive ? null : timerController.initTimer,
              child: const Text('Start Counter'),
            ),
          ],
        ),
      ),
    );
  }
}
