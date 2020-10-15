import 'package:example/testscreen.dart';
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
  CountDownController _controller = CountDownController();
  bool _isPause = false;

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now().second;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: CircularCountDownTimer(
        // Countdown duration in Seconds
        totalDuration: 60,
        currentDuration: time,
        riskTime: 8,
        ristColor: Colors.amber,
        // Controller to control (i.e Pause, Resume, Restart) the Countdown
        controller: _controller,

        // Width of the Countdown Widget
        width: MediaQuery.of(context).size.width / 2,

        // Height of the Countdown Widget
        height: MediaQuery.of(context).size.height / 2,

        // Default Color for Countdown Timer
        color: Colors.white,

        // Filling Color for Countdown Timer
        fillColor: Colors.red,

        // Background Color for Countdown Widget
        backgroundColor: null,

        // Border Thickness of the Countdown Circle
        strokeWidth: 5.0,

        // Text Style for Countdown Text
        textStyle: TextStyle(
            fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),

        // true for reverse countdown (max to 0), false for forward countdown (0 to max)
        isReverse: true,

        // true for reverse animation, false for forward animation
        isReverseAnimation: true,

        // Optional [bool] to hide the [Text] in this widget.
        isTimerTextShown: true,

        // Function which will execute when the Countdown Ends
        onComplete: () {
          // Here, do whatever you want
          _controller.restart(duration: 60);
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (ctx) => TestScreen()));

            // setState(() {
            //   if (_isPause) {
            //     _isPause = false;
            //     _controller.resume();
            //   } else {
            //     _isPause = true;
            //     _controller.pause();
            //   }
            // });
          },
          icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
          label: Text(_isPause ? "Resume" : "Pause")),
    );
  }
}
