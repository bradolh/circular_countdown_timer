import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// Controller for controlling Countdown Widget (i.e Pause, Resume, Restart)
class CountDownController extends ValueNotifier<double> {
  /// Start Time
  DateTime startDate;

  /// Countdown Duration
  Duration totalDuration;

  /// Countdown Duration
  final void Function() onComplete;

  /// true for reverse countdown (max to 0), false for forward countdown (0 to max)
  final bool isStartFromMax;

  CountDownController({
    this.startDate,
    this.totalDuration,
    this.onComplete,
    this.isStartFromMax,
  }) : super(0) {
    resume();
  }

  Duration get elapsed {
    Duration current;

    var now = DateTime.now();
    if (isStartFromMax) {
      var targetDate = startDate.add(totalDuration);
      if (targetDate.isAfter(now)) {
        current = targetDate.difference(now);
      } else {
        current = Duration.zero;
      }
    } else {
      if (now.isAfter(startDate)) {
        current = now.difference(startDate);
      } else {
        current = totalDuration;
      }
    }
    return current;
  }

  bool isActive = false;
  Timer timer;

  void _onTimerChanged(Timer timer) {
    if (startDate == null || totalDuration == null) return;
    if (isActive) {
      var toChange = elapsed.inMilliseconds / totalDuration.inMilliseconds;
      if (toChange <= 1) {
        value = toChange;
      } else {
        value = isStartFromMax ? 0 : 1;
        isActive = false;

        onComplete?.call();
      }
    }
  }

  // This Method Pauses the Countdown Timer
  void pause() {
    if (isActive) {
      isActive = false;
      timer.cancel();
    }
  }

  // This Method Resumes the Countdown Timer
  void resume() {
    if (isActive == false) {
      isActive = true;
      timer = Timer.periodic(Duration(milliseconds: 50), _onTimerChanged);
    }
  }

  /*
  * This Method Restarts the Countdown Timer
  * Here optional int parameter **duration** is the updated duration for countdown timer on Restart
  */
  void restart({DateTime startDate, Duration totalDuration}) {
    if (startDate != null) {
      this.startDate = startDate;
    }
    if (totalDuration != null) {
      this.totalDuration = totalDuration;
    }
    resume();
  }
}
