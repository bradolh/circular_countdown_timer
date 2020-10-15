import 'package:example/main.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FlatButton(
        child: Text('Screen 1'),
        onPressed: () {
          Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (ctx) => MyHomePage(title:'hi')));
        },
      ),
    ));
  }
}
