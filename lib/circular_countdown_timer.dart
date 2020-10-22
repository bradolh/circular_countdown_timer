library circular_countdown_timer;

import 'package:flutter/material.dart';
import 'count_down_controller.dart';
import 'custom_timer_painter.dart';

/// Create a Circular Countdown Timer
class CircularCountDownTimer extends StatelessWidget {
  /// Key for Countdown Timer
  final Key key;

  /// Filling Color for Countdown Timer
  final Color startFillColor;

  /// Default Color for Countdown Timer
  final Color color;

  /// Background Color for Countdown Widget
  final Color backgroundColor;

  /// Width of the Countdown Widget
  final double width;

  /// Height of the Countdown Widget
  final double height;

  /// Border Thickness of the Countdown Circle
  final double strokeWidth;

  /// Text Style for Countdown Text
  final TextStyle textStyle;
  final Color endFillColor;

  /// Optional [bool] to hide the [Text] in this widget.
  final bool isTimerTextShown;

  /// Controller to control (i.e Pause, Resume, Restart) the Countdown
  final CountDownController controller;

  CircularCountDownTimer({
    @required this.width,
    @required this.height,
    @required this.endFillColor,
    @required this.startFillColor,
    @required this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.textStyle,
    this.key,
    this.isTimerTextShown = true,
    CountDownController controller,
  })  : assert(width != null),
        assert(height != null),
        assert(startFillColor != null),
        assert(color != null),
        this.controller = controller ?? CountDownController();

  String getTime(Duration duration) {
    // For HH:mm:ss format
    if (duration.inHours != 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    // For mm:ss format
    else {
      return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.center,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: ValueListenableBuilder<double>(
                          valueListenable: controller,
                          builder: (context, percent, child) {
                            return Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: CustomTimerPainter(
                                      percent: percent,
                                      fillColor: Color.lerp(
                                          controller.isStartFromMax
                                              ? startFillColor
                                              : endFillColor,
                                          controller.isStartFromMax
                                              ? endFillColor
                                              : startFillColor,
                                          percent),
                                      color: color,
                                      strokeWidth: strokeWidth,
                                      backgroundColor: backgroundColor,
                                    ),
                                  ),
                                ),
                                isTimerTextShown
                                    ? Align(
                                        alignment: FractionalOffset.center,
                                        child: Text(
                                          getTime(controller.elapsed),
                                          style: textStyle ??
                                              TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                              ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
