import 'package:flutter/material.dart';
import 'package:time_sense/page/tracker_page.dart';
import 'package:time_sense/service/timer_service.dart';
import 'package:time_sense/service/tracker_service.dart';

void main() {
  runApp(const TimeSenseApp());
}

class TimeSenseApp extends StatelessWidget {
  const TimeSenseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimeSense',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TrackerPage(
          trackerService: TrackerService(),
          timerService: TimerService()
      )
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
