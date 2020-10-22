import 'package:circular_countdown_timer/count_down_controller.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Circular Countdown Timer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Circular Countdown Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CountDownController _controller = CountDownController(
    isStartFromMax: false,
    startDate: DateTime.now(),
    totalDuration: Duration(seconds: 30),
  );
  bool _isPause = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _controller.restart(
                  startDate: DateTime.now(),
                  totalDuration: Duration(seconds: 15));
            },
          )
        ],
      ),
      body: Center(
        child: CircularCountDownTimer(
          // Countdown duration in Seconds
          endFillColor: Colors.yellow,
          // Controller to control (i.e Pause, Resume, Restart) the Countdown
          controller: _controller,

          // Width of the Countdown Widget
          width: MediaQuery.of(context).size.width / 2,

          // Height of the Countdown Widget
          height: MediaQuery.of(context).size.height / 2,

          // Default Color for Countdown Timer
          color: Colors.white,

          // Filling Color for Countdown Timer
          startFillColor: Colors.red,

          // Background Color for Countdown Widget
          backgroundColor: null,

          // Border Thickness of the Countdown Circle
          strokeWidth: 5.0,

          // Text Style for Countdown Text
          textStyle: TextStyle(
              fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),

          // Optional [bool] to hide the [Text] in this widget.
          isTimerTextShown: true,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            if (_isPause) {
              _isPause = false;
              _controller.resume();
            } else {
              _isPause = true;
              _controller.pause();
            }
          });
        },
        icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
        label: Text(_isPause ? "Resume" : "Pause"),
      ),
    );
  }
}
